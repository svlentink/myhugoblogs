---
title: "Open database of exam questions"
date: "2020-07-13"
draft: true
---

This post expands on
[my previous post](post/rethinking-education/).

Open database of exams questions

## Leveraging cryptography to proof fairness

Let's say a new testing facility/organization wants to enter the market
and hasn't got a trust worthy name yet.
It could propose a model where the examinee is able to choose which topics it wants
tested.
Let's explain this with the following example workflow:

1. Examinee picks topics
2. X time before the test (e.g. 1h) a highly volatile public resource is used as a seed (e.g. downloading the webpage of stock market overview or latest Bitcoin hash)
3. This seed is combined with the full name and or birth date of the examinee to create a hash, which in turn is converted a decimal number
4. This number is used to perform a modulo function over the amount of questions available in the open questions database, to retrieve tha amount required (e.g. 2 questions per topic)
5. When the questions are known, they can be printed and only then the total time of the exam is known. (i.e. you will know beforehand that the questions in topic A are 1-2min and topic B 10-30min per questions)
6. The examinee get a personalized, freshly printed exam.
7. Afterwards, the written exam is scanned/photographed and digitally send to the examinee.
8. The final result will be published pubically under the hash, of which the examinee can proof that it's the author, but is not required to.


