# Parcel box

This article describes how to create your own parcel box.
It was motivated by the fact that I found a package in my bicycle crate in front of my house
when coming home after being away for a few weeks.
I still wonder how many there have been there originally but might have been stolen.

In line with my work, I tried to come up with a technical solution that prevents changing the human (delivery guy).
When searching for a solution,
I found that it was already out there,
but too expensive (400eu for a model that I liked),
since I expected to move within a year.


## Motivation design

There are various designs,
like a model with
[two halve cilinders that turing inside each other](https://www.youtube.com/watch?v=fFvoW80r_tg),
allowing for only one way flow of goods
(as see in
[underground garbage deposit units](https://www.amsterdam.nl/afval-en-hergebruik/ondergrondse-afvalcontainers/)).
My requirement was a simple design
that only requires mechanical components and not electronics.
During my search I found two versions;
one with the top opening (as seen in the
[logixbox multibox](https://www.logixbox.nl/producten/pakketbrievenbussen/grote-brievenbus-multibox-m.html)
or
[smart parcel box](https://www.smartparcelbox.co.uk/smart-parcel-delivery-box-medium-green.html))
and
[one](https://www.youtube.com/watch?v=VTmUXU7n9d4)
[with](https://www.youtube.com/watch?v=8N44kmBnPiY)
an opening hatch on the front side
(as seen in the
[Allux 800](https://www.youtube.com/watch?v=DUFgL0sbuOM&)).
Of these two simple designs, the one with the top rotating needs more material and has more moving mass (thus can break more easily),
therefore we opt for the design with the front hatch.


## Material

Besides screws,
glue,
padlock eyes (or screw eyes),
hinges for the door and hatch,
we'll need wood.

You have 3 options:
- `$` (indoor) [2440x1220x18mm OSB](https://www.gamma.nl/assortiment/osb3-18-mm-244x122-cm-rechte-kanten/p/B112332) (do not get the [one with weird edges](https://www.praxis.nl/bouwmaterialen/hout/osb/plaat-osb-tong-en-groef-2-zijdig-18mm-244x122cm/5639971))
- `$` (indoor) [2440x1220x18mm underlayment](https://www.praxis.nl/bouwmaterialen/hout/multiplex/multiplex-underlayment-t-g-122x244cm-18mm/5306959) which will require you to remove the edges
- `$$` Outdoor and painted using 2440x1220x18mm plywood for outdoors (multiplex)
- `$$$` Concrete plywood ([betonplex](https://www.dehoutgroothandel.nl/betonplex)) with smooth surfaces which requires no painting [2500x1250x18mm](https://www.plaatprofi.nl/betonplex-18mm-radiata-pine-250)


## Saw instructions

We will provide the dimensions for a 2440x1220x18mm and 2500x1250x18mm slap of wood.

### Initial 4 equal slaps

We will first get 4 equal sizes from the original:
```
  ____ ____ ____ ____ _____
 |    |    |    |    |     |
 |    |    |    |    |     |
 |    |    |    |    |     |
 |    |    |    |    |     |
 |    |    |    |    |     |
 |____|____|____|____|_____|
```

resulting in 4 slaps of 460x1220x18 (or 470x1250x18) with a remainding slap of 59?x1220x18 (or 61?x1250x18).

### Creating sides
2 of these slaps will be the sides; we remove a triangle, making one side of the top 50mm lower:
```
       ___
 |\     ^
 | \    460mm (or 470)
 |__\  _v_

 |<>|
  50
```

### Back
Grab another of the initially 4 identical slaps and remove 30mm,
resulting in 460x1190x18 (or 470x1220x18).
The backplate is now done.
This results in the backplate not reaching the ground,
since the box will stand on the sides as its legs.

### Front
Due to the removal of the triangles from the sides, the front is 50mm lower than the back.
The final front will look as follows
(see [this animation](https://www.youtube.com/watch?v=DUFgL0sbuOM&)):
```
############ <- slightly slanted roof
 |--------|    ---
 |________|     ^
 | Fixed  |     |
 |________|     |
 |        |    front_covered_height
 |        |     |
 |  Door  |     |
 |        |     v
 |--------|    ---

```
In the middle will be a fixed part,
which has on the inside at the top a hinge.
On this hinge a slap of wood (detailed later) is attached on the inside.
On the top of this hinging slap of wood, we left 30mm free to the top for someone
(with gloves) to open the hatch (hinging slap of wood).

The front height will be 1220-50=1170 (or 1250-50=1200),
of which the `front_covered_height` will be 1170-30-30=1110 (or 1200-30-30=1140).
The two times 30 stands for
the 30mm gap to open the hatch
and the 30mm ground clearance.

#### Fixed part
The fixed part will be 200mm from the top of the front side
(resulting in the packages being able to have a max height of 200-18mm=approx. 18cm).
Thus to determine the fixed part height, we take the `front_covered_height`
minus the swinging hinge part visible (150mm)
minus the door height:
1110-150-590=370 (or 1140-150-610=380)

We remove this part of the last of the untouched of the first 4 initial slaps we created.

#### Bottom
The bottom will be also created from the slap we used for the fixed part.

Since front and back are fixed in between the sides:
```
  _ ________ _
 |s|__back__|s|
 |i|        |i|
 |d|        |d|
 |e|________|e|
 |_|__door__|_|
```
the bottom will be the same width as the backplate (460 or 470)
but the depth will be 460-18-18-10=414 (or 470-18-18-10=424),
where 18 is the thickness of the back and door and 10 is the gap
we will leave between the backplate and the bottom to allow air circulation and water flowing out.

#### Hatch
From the last slap of initially 460x1220x18 (or 470x1250x18),
we removed the fixed part and bottom, resulting in:
1220-370-414-2-2=432 (or 1250-380-424-2-2=442)

#### Door
The initial remaining slap
(thus not one of the 4 identical ones)
will now be used for the top and the door,
which has a width of 59? (or 61?), the '?' is depending on how much was lost due to sawing.
For the door, we will have a 5mm smaller width than the backplate, to allow for the opening and the hinge.
Thus the door will be 59?x455x18 (or 61?x465x18).

This leaves 1220-455-2=763 (or 1250-465-2=783) (where "-2" accounts for the saw loss)
for the roof.


## Assembly

We assume the reader knows how to attach the parts to each other,
which screws/glue to use.

### Hatch to fixed
The hatch will be attached to the top of the fixed part on the inside.
The width of the hatch is the same as the fixed part (460 or 470mm).
Along the length part of the hatch we mark a line at 170mm from the top,
along this line the hatch will hinge.
Thus there will be a 30mm gap above the hatch that will leave room for operating it
and since the majority of the hatch is downwards from the hinge,
it will automatically close itself.

Hatch in open position:
```
   ################## -< roof



  ___________________
 |________.__________| <- hatch
       |f|^
       |i|
       |x|

outside| |inside box
```

Hatch in closed position:
```
   ################## -< roof
          _
         |h|
         |a|
        _|t|
       |f|c|
       |i|h|
       |x| |

outside| |inside box
```

Note that the hatch needs to move freely,
thus you might need to sand a bit along the width to have it running smoothly.

### Backplate
Attach the backplate in between the sides and attach it,
matching the top and having 30mm ground clearance.

### Fixed part
The fixed part (with the hinging hatch attached to it) can be mounted on the front side
in between the sides
with 200mm from the slanted top
(which will make the hatch reaching 170mm higher and providing a 30mm gap for operating it).

### Bottom
The bottom can now be inserted in between the sides,
which 30mm ground clearance and 10mm clearance from the backplate.
This will make the door close rest against the bottom.

### Door
Add the door with the lock eyes on one side and the hinge on the other.

### Roof
Last but not least, add the roof.


