---
title: "Infrastructure as code for faster feedback loops"
date: "2019-06-13"
draft: false
tags: ["management"]
---

Investment banking and managing assets in general require one to make decisions.
Research has shown that making them is done best based on data,
rather than gut feeling.
We measure the output of our system by the metrics provided
and decide and act upon them.
But let's look at the acting part.

The old model is to change the business process (variables),
wait for some data and see if the change had the desired outcome.
This rather takes weeks than hours.
What if we could make this into hours?
Would these faster feedback loop allow us to be more agile,
iterate faster and outpace the competitors?

Infrastructure as Code (IaC) allows one to change the IT infrastructure base on configuration files
or a dashboard.
This makes it possible to launches new versions of our software faster
and also test things more quickly.
It also allows for faster roll backs,
making experimenting more safe.
What it basically means is that you run your blueprint,
instead of creating and measuring afterwards.
You still measure afterwards,
but not the design,
but the outcome it has.

We tech people call it pets vs. cattle.
It's like hand drawn picture vs. printed.
If you draw by hand, you correct it, like you care for your pet.
Your printed version is changed on the computer and reprinted,
just like cattle, if it's sick, you terminated it and get a new one.

### What's in it for the tech team?

Working with cattle, not pets,
being proud of an infrastructure that you truely own,
you can replicate by initiating a script,
making you feel more relaxed about it.

It allows for high availability and faster roll back
if shit hits the fan.

### What's in it for management

If executed properly,
it will require less human capital at a slightly higher infrastructure costs,
which you rent dynamically.

It's liking pressing buttons instead of instructing humans,
you get what you ask for.
Bad managers won't like this, if they give the wrong instructions
or don't listen to the advice of the experts,
everything can go down in an automated fasion,
no humans to blame.

