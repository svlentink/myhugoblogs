---
title: "How much allowance should our kid get?"
date: "2019-08-31"
draft: false
tags: ["math"]
---

When we believe and live in a society that 
embraces the concept
[meritocracy](https://en.wikipedia.org/wiki/Meritocracy),
we can look at the allowance of children in a different way.
This post explains a model for determining the
[allowance](https://www.nibud.nl/consumenten/zakgeld/)
based on performance,
preparing kids for real life.


## Accumulation

We first observe that there are two distinct ways of getting money in a
[welfare state](https://en.wikipedia.org/wiki/Welfare_state)
that are comprehensible for children.

- Sponsored money for being a homo sapien: [bijstandsuitkering](https://www.rijksoverheid.nl/onderwerpen/bijstand) (*guaranteed allowance*)
- Earned money through labor: salary

We also note that concepts like tax systems,
compounded interest, inflation etc. are not 
for kids.

## Income distribution

We observe that some school courses are linked to higher payed jobs than others,
ignoring the pro sports, bestseller authors, rockstars and other top 1 percent jobs.

The following is a suggestion on possible courses,
parents should construct a table based on their own believes.

| course | most jobs | salary |
| --- | --- | --- |
| gymnastics | fitness instructor | $ |
| English | editor | $ |
| science | engineer | $$ |
| mathematics | IT | $$$ |
| biology | nursing | $$ |
| music | cover band | $ |

(given that there are 10 dollar signs, every $-sign is 10% of the total)


## Income composition

We first note that we will not let our kids pay for their own
transportation, housing, food and probably not even clothes initially.
This means that only the percentage of income
that is used for entertainment (and savings?) is what we will give to our kids.
We'll take [`10%`](https://www.quicken.com/home-budget-cost-living-reality-check).

#### Wage

When we plot the
[minimum wage](https://www.rijksoverheid.nl/onderwerpen/minimumloon/bedragen-minimumloon/bedragen-minimumloon-2019)
and extend the line downwards:

<article>
<div id="curve_chart" style="width: 900px; height: 500px"></div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);
//490.7,564.3,646.05,817.8,981.35,1308.5,1635.60
  function drawChart() {
    var data = google.visualization.arrayToDataTable([
      ['Age', 'example_values', 'minimum wage','diff. prev.'],
      ['6',   340,NaN,NaN],
      ['7',   345,NaN,5],
      ['8',   350,NaN,5],        // 5
      ['9',   355,NaN,5],
      ['10',  365,NaN,10],       // 10
      ['11',  375,NaN,10],
      ['12',  400,NaN,25],       // 20
      ['13',  415,NaN,15],
      ['14',  450,NaN,35],       // 37.85
      ['15',  NaN,490.7,40.7],
      ['16',  NaN,564.3,73.6],   // 77.675
      ['17',  NaN,646.05,81.75],
      ['18',  NaN,817.8,171.75], // 167.65
      ['19',  NaN,981.35,163.55],
      ['20',  NaN,1308.5,327.15],// 327.1
      ['21',  NaN,1635.6,327.1],
    ]);

    var options = {
      title: 'Minimum wage NL (july 2019)',
      curveType: 'function',
      legend: { position: 'bottom' }
    };

    var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

    chart.draw(data, options);
  }
</script>
</article>

We observe that the bijstandsuitkering is
[`50%`](https://www.rijksoverheid.nl/onderwerpen/bijstand/vraag-en-antwoord/wat-is-de-bijstandsnorm)
of the minimum wage,
when not living alone.
We will use this percentage as our *guaranteed payout*.

Thus for a 6y old:

- `340` per month `* 10% = 34EU` entertainment money
- of which `50% = 17EU` *guaranteed payout* (welfare allowance for being human)
- `50%` can be earned through meritocracy (good grades, extracurricular etc.)

## Meritocracy

How the additional `50%` can be earned it up to the parent.
The common school, sports and music classes could be in there,
but maybe also helping around the house or
paying attention/writing along in religious meetings.

Let's say that of the `50%` that can be earned,
half of it (`8.50EU`) is earned through school.

Let's say, an `8` is what we aim for at work, if we get a 9, we get a bonus.
When we put this in a sheet (Google sheets, Excel) like the table above
we get:

| course | grade that month | ratio | total |
| ----- | ------ | --- | --- |
| gymnastics | 9 | .1 | .9 |
| English | 6 | .1 | .6 |
| science | 8 | .2 | 1.6 |
| mathematics | 9 | .3 | 2.7 |
| biology | 7 | .2 | 1.4 |
| music | 10 | .1 | 1 |
| | | | |
| | | | = 8.2 |


For that month the 6y old has earned `8.5EU / 8 * 8.2 = 8.71EU` from school grades.

## Suggestions

- Kids need graphs/visuals or explain it in pieces of candy
- Show the connection between change in variable/grade/performance and graph/money
- You don't need a separate graph for school and extracurricular etc., it's all ratios.
- Explain the concept of *guaranteed payout* and the earned part
- Life pays based on outcome, not effort; grades/achievements matter
- Considering [attachment theory](https://en.wikipedia.org/wiki/Attachment_theory); you should not use this model on a 4y old!
- Be an [unconditional loving](https://en.wikipedia.org/wiki/Unconditional_love) parent, a [leader, not a boss](https://www.google.com/search?q=leader+vs.+boss)
- Do not believe anything I say about raising kids, I just like math 

