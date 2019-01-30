---
title: "USB bike charger"
date: "2008-05-09"
draft: false
tags: ["old"]
---

Before the era of solar chargers,
people could charge their phones via their bike dynamo.
Phones back then charged at a maximum of 500mA,
which is close to the 400mA a regular bike dynamo generates.

Nowadays phones require lots more power.
A video of this board can be found
[here](https://www.youtube.com/watch?v=7K567XnTN48).


What you'll need:

+ 50x100mm board
+ 4 diodes `1n5817` (in order of preference: `1n581[7,8,9]` or `1n400[1,2]`)
+ large capacitor: 10-35v, 750-1000uf
+ small capacitor: 10-35v, 10-24uf
+ 7805 (don't get the small 100mA)

What you need to know:

+ Always connect the short pin of a capacitor to ground
+ The ring side of the diode is the side we get our positive
+ The pinout of the 7805 is as follows, hold the text towards you; first is positive input, second is ground and the last is positive output

## Position on board

![board](/img/bikechargeboard1.png "board")

## Connecting wires

![board](/img/bikechargeboard2.png "board")
