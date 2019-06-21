---
title: "Catching support emails from my internet service provider"
date: "2019-06-21"
draft: false
tags: ["whitehat"]
---

We all assume you cannot register admin,
[postmaster](https://webmasters.stackexchange.com/questions/2030/should-i-set-up-standard-email-accounts-what-are-they)
or support@yourisp.com,
however, a Dutch provider let me do a similar thing.
In Dutch we had an old spelling and a new one;
pannekoek (old) and pannenkoek (new), which means pancake.
So I tried to register klanteservice instead of klantenservice,
which was still available!

![vodafonethuis](/img/vodafonethuis.jpg "vodafonethuis")

I didn't look at it for years,
my ISP changed its name,
making me even catch more emails!
The emails I was able to catch were klanteservice at vodafonethuis.nl (old name),
tmobilethuis.nl and t-mobilethuis.nl.

![tmobilethuis](/img/tmobilethuis.jpg "tmobilethuis")


This issue cannot be credited to the ISP,
but to the lack of Dutch of the customers that made this mistake.
However, this typo is easily made, just like suport instead of support.

### Contact with ISP

Via [Hackerone](https://hackerone.com/tmobile) I found an address to contact them.

When I contacted them (6:30PM);
```
Your customers sent sensitive data to a false support email address on your platform.
I was able to register klanteservice instead of klantenservice.
My advice is to:
1) verify your blacklist of email addresses people can register
2) strip me (the user) of that email address
3) let customer support go over those unanswered emails
```

they responded very quickly (7:56PM):
```
Thank you for reaching out.
You have reached the T-Mobile USA; the issue below is with the T-Mobile/Netherlands.
We have forwarded your communication to them ( REDACTED ) and requested that they contact you.
Thank you for engaging in responsible disclosure and helping us keep T-Mobile customers, in the USA and in Europe, safe.
```

This response brings a smile to my face,
a company that understands the concept of white hat hackers.

The Dutch CERT team handled it great and sent me some gifts.

![tmobilegift](/img/tmobile-thankyou.png "tmobilegift")

