---
title: "Digital nomads should ignore timezones"
date: "2022-10-28"
draft: false
tags: ["digital-nomad"]
---

Timezones are an approximation of the time in a place,
which can be off by more than two hours.
Remote workers and digital nomads work for companies outside of the city they stay in,
thus not the prescribed local time is relevant,
but actual local time.

## Solar noon

Instead of focusing on timezones,
let's see when the sun is on it's middle point during the day.
Use this solar noon (ideally at 12:00) to compare time differences
(or use the timezone of the place you work for and locally the actual time).

Let's show an
[example](https://www.timeanddate.com/worldclock/converter.html?iso=20221028T130000&p1=16&p2=44&p3=209&p4=325&p5=4529&p6=26&p7=239&p8=923&p9=54)
for 2022-10-28,
having Amsterdam as working location;

| city | longitude| timezone | solar noon | solar noon timezone |
| --- | --- | --- | --- | --- |
| [Amsterdam](https://geotimedate.org/sun/netherlands/provincie-noordholland/amsterdam) NL | +4.9 | +2 | 13:24 | +0.5 |
| [Recife](https://geotimedate.org/sun/brazil/pernambuco/recife/3390760) Brazil | -34.9 | -3 | 11:03 | -2 |
| [Kolkata](https://geotimedate.org/sun/india/west-bengal/kolkata/1275004) India | +88.4 | +5.5 | 11:20 | +6 |
| [Mumbai](https://geotimedate.org/sun/india/state-of-maharashtra/mumbai/1275339) India | +72.9 | +5.5 | 12:22 | +5 |
| [Valencia](https://geotimedate.org/sun/spain/comunitat-valenciana/valencia/2509954) Spain | -0.4 | +2 | 13:45 | 0 |
| [Matosinhos](https://geotimedate.org/sun/portugal/distrito-do-porto/matosinhos/2737824) Portugal | -8.7 | +1 | 13:18 | -0.5 |
| [Vigo](https://geotimedate.org/sun/spain/galicia/vigo/6360254) Spain | -8.7 | +2 | 14:18 | -0.5 |
| [Athens](https://geotimedate.org/sun/greece/attica/athens) Greece | +23.7 | +3 | 13:08 | +2 |
| [Stockholm](https://geotimedate.org/sun/sweden/stockholm/stockholm/2673730) Sweden | +18 | +2 | 12:31 | +1.5 |
| [Cancun](https://geotimedate.org/sun/mexico/estado-de-quintana-roo/cancun) Mexico | -86.9 | -5 | 12:31 | -5.5 |


Observe;

- India is using half an hour timezones
- Amsterdam is 1.5h off of it's timezone and Vigo more than 2.
- Difference Amsterdam - Kolkata
  - Timezone: `5.5-2= 3.5h`
  - Solar noon: `6-0.5= 5.5h`
  - longitude: `88.4-4.9= 83.5`
- Difference Amsterdam - Recife
  - Timezone: `-3-2= -5h`
  - Solar noon: `-2-0.5= -2.5h`
  - longitude: `-34.9-4.9= -39.8`

We see that timezones are misleading,
they make us believe NL is closer to Kolkata than Recife by `(5-3.5=) 1.5h`,
while in reality, **Recife is `(5.5-2.5=) 3h` closer than Kolkata**.
These numbers thus show a `(1.5+3=) 4.5h` discrepancy!

## Longitude

[Comparing cities](https://weatherspark.com/compare/y/51381~31432~42614~32421~89228~84156/Comparison-of-the-Average-Weather-in-Amsterdam-Recife-Valencia-Matosinhos-Athens-and-Stockholm)
for remote working should thus not be based on timezones,
but solar noon.
Or as a rule of thumb we look at longitudes for an easy comparison for time differences;

- Recife `(-34.9-4.9)/360*24= -2.65h`
- Kolkata `(88.4-4.9)/360*24= 5.6h`
- Mumbai `(72.9-4.9)/360*24= 4.53h`
- Matosinhos/Vigo `(-8.7-4.9)/360*24= -0.9h`
- Valencia `(-0.9-4.9)/360*24= -0.4h`
- Athens `(23.7-4.9)/360*24= 1.3h`
- Stockholm `(18-4.9)/360*24= 0.9h`
- Cancun `(-86.9-4.9)/360*24= -6.1h`

