---
title: "Solar noon based time"
date: "2019-06-25"
draft: true
---

TOREAD: https://en.wikipedia.org/wiki/Equation_of_time
Was used in the past: https://www.timeanddate.com/time/local-mean-time.html


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
![example noon](/img/google-weather-noon.png "example noon")
```
dawn       = 04:25
sunrise    = 05:15
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
To 'compute' the DST, we need the `UTC + timezone`.

The new time we'll call Solar Noon Time (SNT) for now.
To 'compute' the SNT, we need the `UTC + longitude`.

```
<span id="times-container"></span>
```

<script>


Date.prototype.toSNTString = function(long = 51) { // longitude = meridian
  var YYYY = this.getUTCFullYear()
  var MM = this.getUTCMonth()
  var DD = this.getUTCDate()
  var hh = this.getUTCHours()
  var mm = this.getUTCMinutes()
  var ss = this.getUTCSeconds()
  return YYYY + '-' + MM + '-' + DD +
    'T' + hh + ':' + ss +
    '@' + long + ' TODO math not yet implemented'
}

getTimeString = () => {
  var now = new Date()
  return "DST = " + now.toString() +
//    "\nUTC = " + now.toUTCString() +
    "\nUTC = " + toISOString().substr(0,16) +
    "\nSNT = " + now.toSNTString()
}
</script>

Just like we have multiple clocks at the airport for different DST timezones,
we could have another extra clock,
showing the SNT time for that location.
This time does not need to replace the other time notations,
it's
**just another representation of UTC based on location**.

## Religion

This timing schedule is possible due to advancements in science,
making it easy to calculate the time everywhere by a digital watch or phone/computer.
Religious people would benefit from this timing scheme,
since their times of fasting/prayer or other customs would align more easily.

## Alternative time and dates

If we were to changes the time
one could
[argue](https://youtu.be/rtB93yzgedc)
to also switch to
[International Fixed Calendar](https://www.citylab.com/life/2014/12/the-world-almost-had-a-13-month-calendar/383610/),
but this is not in the scope of this article.

Links:

- [Swatch Internet Time](https://en.wikipedia.org/wiki/Swatch_Internet_Time)
- [International Fixed Calendar](https://en.wikipedia.org/wiki/International_Fixed_Calendar)
- [Solar time](https://en.wikipedia.org/wiki/Solar_time)
- [Sun transit time](https://en.wikipedia.org/wiki/Sun_transit_time)
- [Solar noon](https://en.wikipedia.org/wiki/Noon#Solar_noon)
- [Sidereal vs. solar time](https://en.wikipedia.org/wiki/Sidereal_time#Comparison_to_solar_time)


## Timezone dimensions

width per timezone
```
hour      = 40.000km/24  = 1667km
longitude = 40.000km/360 =  111km
```

time difference per timezone
```
hour = (24h*60m)/24h = 60min
long = (24h*60m)/360 =  4min
```

Depending on the season,
you might have
[15 min](https://en.wikipedia.org/wiki/Equation_of_time#The_concept)
more or less in a day.

