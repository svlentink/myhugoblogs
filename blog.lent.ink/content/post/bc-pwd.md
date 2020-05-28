---
title: "Blog BC"
date: "2020-04-15"
draft: true
---


# How do we backup our passwords? A thought on our online Security.


Most people know by now that we shouldn't reuse our passwords
across websites.
We also know we need two factor authentication (2FA).
Some even claim that SMS isn't a real 2FA,
since the phone system (SS7) is broken.

What we know is that we need to use a password manager
and login via Google/Microsoft Authenticator,
you know, that app that has a 6 digit number that changes every few seconds.

This article describes the essential aspects of managing your passwords and authenticator app,
highlighting the importance of having a backup and showing an alternative way of managing passwords.

## Why do we do this?

The current advice is base on the principle that we login with something we know
(password) and something we have
(nowadays an authenticator app installed on a phone and previously an RSA token device).

We cannot use the same password for multiple websites,
since one hacked/fake website would provide your login (email) + password
for other websites as well.

## What is secure?

Information security experts will point to CIA;
Confidential (keep secret),
Integrity (correct data, not been tampered with)
and Availability (being able to access the information).

Our passwords and authenticator app that uses time tokens (TOTP)
also have these three requirements.
As long as we only copy passwords and do not type them,
the integrity will be kept,
since manual entry could
[confuse a zero and an 'O' or a capital 'i' and a lowercase 'l'](https://wikipedia.org/base58).

Keeping it a secret and being able to access the data are somewhat linked.
We want to store the data in a way that only we can access it,
but it should also have a backup that we can access when needed.

But before going addressing storing and backup, we need to know why we need 2FA.

## Multi factor authentication

Passwords can be stolen in a lot of ways and therefore many websites
want a second proof.
This second proof needs to be a different thing,
not a second thing 'you know'.

In the past, SMS was used,
since it was a proof that you have access to the physical SIM card.
Nowadays, this is done through time tokes from the authenticator app
installed on a phone; also a proof of something you have.
There are also people who use a password manager that also functions
as a time token generating app,
which reduces the security to a since thing again!

We don't mention biometrics, since this has extra technical requirements,
making it not generic enough for web applications.

## How do these techniques work?

Before we can explain the inner workings, you need to understand what a
[cryptographic hash function](https://en.wikipedia.org/wiki/Cryptographic_hash_function) (CHF)
is. For now, just remember that a CHF always returns the same value if the input is the same.

For the time token, we see that the initial setup is done by scanning a QR code with the authenticator app.
During this step, the authenticator app receives a secret by scanning it.
This secret is used to generate the time tokens.

Image we have the secret + the current time (2020-04-15T14:45:5x).
If we take this secret + current time (minus the last digit of the seconds indicator),
we have a unique input for the CHF every 10sec.

```
INPUT                  APP      TOKEN
-------------------|---------|-------
      secret
        +           => CHF => 123 789
2020-04-15T14:45:5

```

Important to remember is that the authenticator uses as secret
to generate the time tokens.


The user aspect of passwords is known to most users,
maybe you even use a password manager.
On the website backend, the passwords are never stored (if done correctly),
but only the output of the CHF.
The password + a
[salt](https://youtu.be/8ZtInClXe1Q?t=442)
(random value) is put in the CHF and the result + salt is stored.

```
INPUT      website              hash used to verify password
---------|---------|----------------------------------------
 salt
   +      => CHF => 84e97eb9dfe4b378176b37996b9ac24d6f03dd7e
password
```

Websites use a unique salt for every password
to prevent the same hash being stored if people have the same password.


## Intermezzo: What do we know now?

For the majority of web services we want to have a:
- strong and unique password
- second factor using a generated (time based) token

These two aspects need to be:
- kept confidential/secret
- available to the user


## Authenticator app

When using an authenticator app, I personally like to backup the secret used to generate the time tokens.
This allows me to lose/break my phone without me losing access to my accounts.

To backup my time token secrets,
I use a
[CLI based tool](https://github.com/svlentink/dockerfiles/tree/master/svlentink/totp-backup)
to be in control of my secrets,
but normal people would probably entrust an app like
[Authy](https://authy.com).

Ask yourself, do you have a backup 2FA when your authenticator app
&mdash; or the device it is installed on &mdash; fails?


## Password management

When it comes to passwords for work,
I follow the guidelines of the company.
If they have a password manager that creates a backup
to a service they trust, I'm fine with that.

For my personal usage, I don't want to sync to a free online password manager,
simply because I don't trust them.
Besides security considerations, if it's free,
they can cancel/block my account at any time.
This brings me to the question;
how to securely backup passwords?


## Password backup

Conventional password managers generate a random password for every service.
These passwords are stored and this storage needs to be backed up in a secure way.

But looking at what we learned earlier,
the thing with salts,
we see that one password gives different hashes based on different salts.
If we use this technique per website,
we get a different password for every website.

```
INPUT            password generator      unique password
----------------|------------------|--------------------
master_password
      +          ======> CHF ======> password for domain
domain (salt)
```

On a UNIX shell this could look like:
```shell
$ echo MY_SECRET_PHRASEfacebook.com | shasum
5e1ff47fd34ec0a3ee94a348fb6e4362ee9da1f5
```
where we say (echo) our secret + the website domain to the CHF (shasum),
which returns us the hash (5e1ff47fd34ec0a3ee94a348fb6e4362ee9da1f5).

This system would let us derive a new password for every website
from one master password
(just like you have a master password to login to a password manager).
The best thing is, we only need to
[remember a master password](https://xkcd.com/936/)
and not backup our storage.

But please don't use the example shown above
since there are
[password generators](https://lent.ink/projects/pwd/)
that have implemented this in a better way.

## Conclude

Security usually isn't convenient, but we need it.
This article has highlighted the importance of having a backup
of your secrets;
your passwords and the secrets used for generating time tokens.
Some type of secrets need to be stored (for time tokens) and require a backup
and others can be derived from a master secret (for passwords).



