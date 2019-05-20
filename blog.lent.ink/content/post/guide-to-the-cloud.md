---
title: "Guide to the Cloud"
date: "2019-05-09"
draft: true
tags: ["kubernetes"]
---

The biggest difference between the cloud is (or should be)
that in the past your environment was managed and cared for
by creating inventory lists and managing existing environments,
known as pet machines.
The cloud enables us to define the desired environment in configuration files
and tell the cloud provider to run it, which we call Infrastructure as Code (IaC).

Many people claim that the cloud is just ~~someone else computer~~,
which is not the big benefit of the cloud.
It should not be about outsourcing your hardware
but changing from your environment defining the state of your infrastructure and appliction,
to your configuration defining it.

First we assume one understands the following concepts;

- Monolith vs Micro services: in a rapid changing environment, micro services allow new developers to join a project fast. Just Google the topic, you probably want it.
- Stateful vs. stateless: containers force us to think about data storage and services interconnections.
- IaaS, PaaS, SaaS: software in a container, on a PaaS (k8s) running at a cloud provider (IaaS) such as AWS, Azure and Gcloud.

## Migrate to the Cloud

Every organization is different and politics is not my game, good luck.
Here's the technical roadmap.

### step 00 Container store

First things first; we need a pipeline in which Git is the input
and a container is the output.

An example of the first part of this flow could be:

![Gitflow](/img/gitflow.png "Open with draw.io to edit, src: github.com/SuperBuddy/ci")

Other things to include in this pipeline are tests,
such as coding conventions, possible security issues, unit and integration tests.

We now have the basis for starting our transition.

### step 01 In place container

### step 02
