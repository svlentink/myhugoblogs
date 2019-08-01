---
title: "Development in DMZ"
date: "2019-08-01"
draft: false
tags: ["security", "management"]
---

Corporate environments usually have more (advanced) (network) security measures in place.
For developers this means that getting any random package from the internet into
the environment (enclave) where the sensitive data lives is impossible,
which is a good thing.
Let's agree that security is important and that efforts of it should always be admired,
since we cannot get enough people to be security minded.

## Developers freedom compromized

Development is the creation of something new,
otherwise you are just building.
Developer are usually keen on learning
[new tools](https://www.stackoverflowbusiness.com/blog/why-developers-want-to-always-be-learning)
to get the job done.

However in a *secured corporate environment* it could be that only the
default packages of the default OS (e.g. Redhat) are available.

Let's not go into detail about the implications,
the people who've been in such an environment will know.
It limits creativity, demotivates (less productive), limits efficiency,
creates suboptimal solutions (which usually take longer to implement),
and makes skilled people circumvent existing limitations
(i.e. avoiding security measures or even creating backdoors/tunnels).

The basic problem in my opinion is;
hire a creative mind,
limit his ability to be creative in his usual job
and he will use his creativity to be able to do his job as usual.

Let's stop losing creativity in the invention of circumvention
and create an environment that has no need for this behavior.

## From DMZ to [enclave](https://en.wikipedia.org/wiki/Network_enclave)

When we let developer code in a demilitarized zone (DMZ; open network),
we need a safe way of transfering the assets (code) to the enclave,
without introducing a security risk.
While securing it, let's make it auditable as well.

One way of doing this could be to only allow data entering from the DMZ
to our network via Git:

```
public            network
internet | VPN  | enclave
         |      |   ________
browser->| :443-|--|  self  |
gitpush->| :22--|--| hosted |
         |      |  |__Git___|
         |______|      |
         |         CI/CD flow
         |             |
         |         ____V______
         |        | container |
dep.s  <===tunnel=|   build   |
         |        |___node____|
         |             |
         |   container security scan
         |         ____V______
         |        | container |
         |        |_registry__|
DMZ      |

```
Developers can mimic the environment it will be deployed in when everything
is deployed using a container (OCI).
The dependencies
that software need are installed in the container as well,
which are not added to the code base (archive) but referenced.
This reference (e.g. installation instruction in Dockerfile)
needs to be accessible by the container build node.

Everything the developer want into the enclave goes through git.
To enable building a container (thus pulling public resources),
the code needs to be merged to the master git branch,
which requires a reviewer/auditor.

Side note:
*when we keep the old containers,
we don't need our own mirror of packages and images,
which was a good practice back in the day.*

## Securing the workflow

Let's secure the system, not the people using the system.
We want a secured workflow that facilitates users (developers),
while enforcing the
[integrity of the system](https://en.wikipedia.org/wiki/System_integrity).

It should not be possible to manually push containers into the registry,
everything should be build/deployed automatically from the code that is in Git.
Enforcing the workflow makes everything that is pushed onto the network auditable,
if and only if:

- we keep a history of our container images (which contain the packages)
- developers need to specify a hash for everything they download without the default package manager
- the file hashes need to be verify in the build definition of the container (i.e. Dockerfile)

This approach enables developers to be free to develop new services using the tools they want,
being accountable for the decisions they make,
which are logged through Git history.

*This workflow does not require Infrastructure as Code (IaC),
but it does required the same mindset.*



