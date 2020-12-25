





## Motivation design

There are various designs,
like the
[two halve cilinders turing inside each other](https://www.youtube.com/watch?v=fFvoW80r_tg)
allow for only one way flow of goods,
as see in
[underground garbage deposit units](https://www.amsterdam.nl/afval-en-hergebruik/ondergrondse-afvalcontainers/).
We want to use a simple design,
which I found two versions of,
one with the top opening (as seen in the
[logixbox multibox](https://www.logixbox.nl/producten/pakketbrievenbussen/grote-brievenbus-multibox-m.html)
or
[smart parcel box](https://www.smartparcelbox.co.uk/smart-parcel-delivery-box-medium-green.html))
or
[one](https://www.youtube.com/watch?v=VTmUXU7n9d4)
[with](https://www.youtube.com/watch?v=8N44kmBnPiY)
an opening hatch on the front side
(as seen in the
[Allux 800](https://www.youtube.com/watch?v=DUFgL0sbuOM&)).
Of these two simple designs, the one with the top rotating needs more material and has more moving mass (thus can break more easily),
thus we opt for the design with the front hatch.


## Material

You have 3 options:
- `$` Indoor [2440x1220x18mm OSB](https://www.gamma.nl/assortiment/osb3-18-mm-244x122-cm-rechte-kanten/p/B112332) (do not get the [one with weird edges](https://www.praxis.nl/bouwmaterialen/hout/osb/plaat-osb-tong-en-groef-2-zijdig-18mm-244x122cm/5639971))
- `$` indoor [2440x1220x18mm underlayment](https://www.praxis.nl/bouwmaterialen/hout/multiplex/multiplex-underlayment-t-g-122x244cm-18mm/5306959) which will require you to remove the edges
- `$$` Outdoor and painted using 2440x1220x18mm plywood for outdoors (multiplex)
- `$$$` Concrete plywood ([betonplex](https://www.dehoutgroothandel.nl/betonplex)) with smooth surfaces which requires no painting [2500x1250x18mm](https://www.plaatprofi.nl/betonplex-18mm-radiata-pine-250)


## Saw instructions

We will provide the dimensions for a 2440x1220x18mm and 2500x1250x18mm slap of wood.

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

2 of these slaps will be the sides thus we remove a triangle, making one side of the top 50mm lower:
```
       ___
 |\     ^
 | \    460mm (or 470)
 |__\  _v_

 |<>|
  50
```
resulting the sides being done sawing.

Grab another of the initially 4 identical slaps and remove 30mm,
resulting in 460x1190x18 (or 470x1220x18).
The backplate is now done.
This results in the backplate not reaching the ground,
thus that the final box will stand on the sides as its legs.

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
The two times 30 stands for the gap top open the hatch on the top and the 30mm ground clearance of the door.


