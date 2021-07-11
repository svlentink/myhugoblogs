---
title: "Prepaid cloud services"
date: "2021-07-11"
draft: true

---

People who've worked with cloud services while in development phase
probably have encountered having unexpected costs by forgetting to terminate unused resources.
We safe guard ourselves by excessive over runs of phone bills by children by giving them
a prepaid sim card, making them more aware and mindful of the costs.
Why not do the same for
[cowboy coding](https://en.wikipedia.org/wiki/Cowboy_coding)
developers?

## Technical outline

- Debit accounts hold the potential to spend currency.
- Developers can use a cloud subscription tied to that account.
- The cloud subscription is managed by the platform (call it Prepaid cloud services provider PCSP).
- If the PCSP detects that the funds on the account dip below x, it kills off all resources except storage marked as stateful.

The PCSP takes x amount (e.g. `0.5%`) of all debited currency as service fees
(thus also applies to returned currency).

## Potential usage

Developers get their account topped up with x currency each month and are free to use as agreed.
All the unspend currency or everything above the minimum threshold is returned back to the customer of the PCSP before the end of the fiscal year of the PCSP.

## Fiscal year deviance

The unspend or excess amount of currency is returned to the customer before the end of the fiscal year of the PCSP,
because otherwise the year statements of the customer and PCSP will be impacted.

To enable different
fiscal years
(since countries
[differ](https://www.cia.gov/the-world-factbook/field/fiscal-year)
or even let you
[chose](https://www.youtube.com/watch?v=t881ZBK8S5o&t=1615s)),
the scheduling of money return should be programmable/customizable.

#### Example use case

PCSP is located in Estonia and uses 1feb - 31jan as its fiscal year.
This PCSP has in it statements that all currency it deems excess will be refunded in the last week of Jan,
to close its fiscal year.
If MaliciousCorp (customer) now uses this PCSP for $10.000 a month and only spends $10 per month and has a fiscal year from 1jan - 31dec,
and does not state it wants to have its excess funds returned at the end of December,
it uses PCSP as a way to surpress its profits, while receiving it all in January again.

## Implementation

The services of PCSP can be automated through payment automation and cloud services automation.

The PCSP should have a common fiscal year
(e.g. India and UK differ from EU),
since starting a PCSP with a fiscal year on 1feb
that caters to the EU market may be perceived as a tax avoiding scheme.


