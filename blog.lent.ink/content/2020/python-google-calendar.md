

```python
#!/usr/bin/env python3

# sudo pip3 install icalevents typing
# the URL is called the following on Google Calendar
# 'Secret address in iCal format'
URL = 'https://calendar.google.com/calendar/ical/REDACTED%40group.calendar.google.com/private-REDACTED/basic.ics'
path = '/tmp/temperature'
default = 15

from icalevents.icalevents import events
from datetime import datetime


es  = events(URL)
now = datetime.now()
for e in es:
  # use string comparison, otherwise;
  # TypeError: can't compare offset-naive and offset-aware datetimes
  if str(e.start) < str(now) < str(e.end):
    val = e.summary
    with open(path, 'w') as f:
      f.write(val)
    print('Set temperature to',val)
    exit()

print('Nothing found, using default',default)
with open(path, 'w') as f:
  f.write(str(default))

```
after saving, make sure to make it executable:
```shell
chmod +x /usr/local/bin/calendar-temp
```
after running the script, you can test it using:
```shell
if [ "`cat /tmp/temperature`" == "15" ]; then echo currently using the default;else echo has been set; fi
```

