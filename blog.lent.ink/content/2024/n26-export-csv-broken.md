---
title: "N26 export CSV missing records fix"
date: "2024-07-27"
draft: false
tags: ["coding"]
---

N26 is one of the awesome free banking options in Europe.
Have been using it for years and sometimes had that my books didn't line up.
Never thought much of it.

Now I found out that if you
[export](https://app.n26.com/downloads/) a CSV per quarter,
it might not include records of the last day of your selected timespan.
It took me years to find out the CSV function left out records.
To work around this error,
just select with a few days margin and then manually remove the rows not belonging in the quarter.

I've tried to point out this error,
but I only get a chatbot
and writing this blog was just easier than trying to chase them.

