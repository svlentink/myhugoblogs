---
title: "Solar noon based time"
date: "2019-06-25"
draft: true
---

In our current culture, planning and time allow us to efficient as a society.
To be more efficient, the EU wants to stop the twice a year switching of time,
called Daylight Saving Time (DST).

However, we already have a shared time with us all the time
in our computers and phones: UTC (Coordinated Universal Time),
which is the successor of GMT.
These micro processors agree on a time using the
Network Time Protocol
([NTP](https://developers.google.com/time/)).

Humans have used the sun as an indicator from the start,
which is still used around the world,
for example to know when to pray and fast.

## Example

Example of the place and day I wrote this post:
```
dawn       = 04:25
sunrise    = 05:17
clock noon = 12:00
solar noon = 13:40
sunset     = 22:05
dusk       = 22:55

solarnoon - dawn = 09:15
dusk - solarnoon = 09:15
clocknoon - dawn = 05:35
dusk - clocknoon = 12:55
```

We see that solar noon
and the noon we observe on our clocks
differ a lot.

## Solar noon = clock noon

Forget the time you need to be somewhere (work)
and let's assume that is flexible
and thus can be adapted to what is logical for your
location, moment and circumstances.

When we assume `solar noon = clock noon`,
we have the following facts that stay the same:

- The day holds 12h before noon and 12h after noon.


features that would be added:

- same hours of daylight before and after noon

## 3 times

We now have two times we use, UTC internally on our computers
and the 'normal' time we use,
which I'll call DST for now.

The new time we'll call Solar Noon Time (SNT) for now.

```
new Date().getTime()
https://stackoverflow.com/questions/8047616/get-a-utc-timestamp
```


## Religion

This timing schedule is possible due to advancements in science,
making it easy to calculate the time everywhere by a digital watch or phone/computer.
Religious people would benefit from this timing scheme,
since their times of fasting/prayer or other customs would align more easily.

