---
title: "Theoretical optimum for shower curtain"
date: "2021-01-01"
draft: true
tags: ["category01"]
---

![example-alt](/img/example.png "example-alt")


explain situation



Given a shower curtain of 1800mm wide.
The outermost holes have a 35mm distance from the edges.
We want the first holes to start at 15mm,
giving us 20mm that will touch the wall.

When we attach the curtain to the outside of the frame, this will give us
maximum outer frame length of
`1800 - (2*35) + (2*15) = 1760`,
if we now allow for 10mm room to not fully tension it,
it's 175cm.

The given dimensions are 91 and 100cm.
If we were to make it two straight pieces,
this would result in 191cm.
Thus we need to reduce the sides with
`191-175=16cm`, thus `8cm` per side.

If we use want a 45 degree angle,
we observe that the reduction of one side
also reduces the other side with the same length.

To find the length of a 45 degree angle,
we use the 1, 1, `sqrt(2)` triangle.
And observe that reducing one side (thus both)
leads to a saving of overal length.

The factor by which this is achieved is:
```
2-sqrt(2)
```
or for one side: `1-(0.5(sqrt(2)))`.

We now see we need to reduce both sides by:
```
16/(2-sqrt(2)) = 8/(1-(0.5(sqrt(2)))) = 27.31

```
Which will give us a long side of:
```
sqrt(2)*16/(2-sqrt(2)) = 38.63
```
Adding everything together gives us:
```
91-27.31=63.69
100-27.31=72.69

63.69 + 72.69 + 38.63 = 175.01

```

However, these are only the outer dimensions.
We now pick the style we want:

```
A: center beam attached to outside
             |  |
             |  |
             |  |
             |╱| 
            ╱ ╱
          ╱ ╱
________╱ ╱
______╱_╱


B: center beam attached to inside
             |  |
             |  |
             |  |
             |  | 
            ╱|╱
          ╱ ╱
________╱_╱
________╱

```

We'll go for the drawing B since it is easier to get the measurements for.

For this project we use a beam/pole with width of 44mm.
Which will result in one side being
63.7cm on the short side and (63.7+4.4=68.1cm),
these are the first two markings on the pole.

We now observe that the short side of the middle pole
is reduced by the sides by 2 times a 45 degree angle.
Thus this side will have a length of
38.63-(2*4.4*sqrt(2))=26.2.

On the side we marked 68.1, we also mark
68.1+26.2=94.3.
On the side we marked 63.7, we also mark
63.7+2*4.4+26.2=94.3+4.4=98.7.

Now we need to mark the end of the other side beam at
94.3+72.7=167.

And to do a final calculation:
167+2*4.4*sqrt(2)-4.4=63.7+26.2+72.7+2*4.4*sqrt(2)=175.05



Enjoy finding the theoretical optimum for utilizing as few resources as possible, while still being comfortable.
- sealskin 180cm wide 2m high shower curtain
- wooden pole
- screws
- wood glue
- 3x eye screws (in ceiling)
- rope (clothes line)


