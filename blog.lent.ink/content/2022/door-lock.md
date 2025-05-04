---
title: "Industrial door lock home"
date: "2022-09-12"
draft: false
tags: ["DIY"]
---

There are lots of electronics for smart homes on the markt nowadays.
But I did not want to hand out the keys to my home and private network
to a third party.
I've done that before, using a Sonoff device,
which resulted in me not being able to turn my heater on or off when their server was down.

## Why consumer smart home product are bad

- Configuration is manual, no IaC
- Usually Wifi, which makes password rotation manual, thus hard
- External third party has an entry onto your network
- Often only works when connected to internet, not just local Wifi network
- IT/Network security? Updates and security patches?
- External party collects data of your private network/environment
- Configuration of storing IP security cam to local NAS is harder than using external service
- IPv6 compatibility

To work around a few of these problems,
I've set up a separate Wifi network before,
with limit network capabilities,
with no password rotation.
However, it turned out that some devices require the controlling device to be on the same SSID (chromecast),
which doesn't make sense if they talk over ethernet.
This specific approach is also very tedious and not repeatable for non network engineers.

## Solution

- 6eu webcam (Trust Exis)
- 10eu OrangePi Zero
- 18eu industrial [door lock](https://www.leroymerlin.pt/pesquisa/Testa%20eletrica?orderby=priceup&price-filter=10%2C36&price-filter-low=&price-filter-high=&selectorderby=priceup&filterprice=true)
- 7eu [12v power supply](https://www.leroymerlin.pt/Produtos/Eletricidade-e-domotica/Casquilhos-e-acessorios-iluminacao/WPR_REF_17683981)

This setup allows me to open my door when connected to Wifi
and the webcam takes pictures when the door is opened.

I already had an OrangePi with relay lying around from
[an old project](https://blog.lent.ink/post/diy-cheatsheet/)
and decided to use it here.

The following code is my first iteration;

```python
#!/usr/bin/env python3

import OPi.GPIO as GPIO
import os
import time
import datetime
from flask import Flask
from flask import request

pin = 24 #which is PA13 on pinout
GPIO.setmode(GPIO.BOARD)
GPIO.setup(pin, GPIO.OUT)
GPIO.output(pin,True)
app = Flask(__name__)


last_triggered = datetime.datetime.now()


@app.route('/', methods=['GET'])
def serve_homepage():
    global last_triggered
    now = datetime.datetime.now()

    try:
        if (now - datetime.timedelta(seconds = 20)) < last_triggered:
            return ('Already triggered in the past 20sec',403)

        GPIO.output(pin,False)
        # use the following line if you do not have a door sensor
        #os.system('''nohup capture-webcam &''')

        nowstr = now.isoformat()[:16]
        with open('/var/log/door-open-triggered.txt', 'a') as f:
          f.write(f"{nowstr}\n")
    except:
        print('Something went wrong')
    finally:
        time.sleep(3) # have the door unlocked for 3sec
    GPIO.output(pin,True)

    last_triggered = now
    return('OK',200)


if __name__ == '__main__':
  app.run(debug=True, port=80, host='::')
```

`/usr/local/bin/capture-webcam`:
```
#!/bin/bash
for i in {0..9}; do
    fswebcam -D 0.7 -r 640x480 /pics/`date -Is`.jpg;
done
```

#### monitoring the door using a door sensor

`/usr/local/bin/monitor-door.py`:
```
#!/usr/bin/env python3

import OPi.GPIO as GPIO
import os
import time
import datetime

pin = 23 #which is PA14 on pinout
GPIO.setmode(GPIO.BOARD)
GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def door_open_recently_triggered(fn="/var/log/door-open-triggered.log"):
  with open(fn,"r") as f:
    filecontent = f.read()
  return datetime.datetime.now().isoformat()[:16] in filecontent

def door_is_open():
  return GPIO.input(pin) == GPIO.HIGH

while True:
    time.sleep(0.3)
    if door_is_open() and door_open_recently_triggered():
        os.system('capture-webcam')


```

## Side notes

Electric door locks may come with a memory function,
which means that if you open the door it waits for someone to also actually open it.
It turned out I did not want this feature.

I placed two door locks in my door and have a manual knobs on one side of the euro cylinders.

The most time was spend on inserting a new lock in the door
and carving out the holes in the door frame wood (and underlying stone).


#### Camera problems?

```
apt install -y fswebcam
depmod
modprobe -r uvcvideo
modprobe uvcvideo
```

#### Electrical safety switch

You should either incorporate a time relay into your switch mechanism
or use a spring loaded button (e.g. doorbell) to switch the circuit to the lock.
For my first run I did not do this.
I used an old OrangePi Zero (ubuntu 14 in 2022) which 3/4 times did not manage to start SSH server.
This unreliable device I used during testing, also with the webcam code.
The webcam code failed, the relay stayed engaged and the door lock(s) fried.
Therefore have a separate time relay or use a button inside the circuit.

In the case of a button:

```
      relay      button           __
      |___|        |             /  \
        |        __|__         _/____\_
+ ______/ ________   _________|  door  |
- ____________________________|  lock  |
                              |________|
```
