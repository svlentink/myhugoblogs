---
title: "Migrating server from Scaleway to Hetzner"
date: "2020-10-13"
draft: true
---

Earlier this year I migrated my server setup from a
[docker-compose composition](https://github.com/svlentink/dockerfiles/tree/master/docker-compose/mywebsite)
to a
[kubernetes orchistrated](https://github.com/svlentink/myinfra) one.
This gave me automatic TLS certificates (which are easier in k8s),
but I traded it for CPU and memory consumption by using k8s with cert-manager.
This setup was running some static websites, wordpress (PHP + MariaDB) and a WebIDE (cloud9, NodeJS).

Since I was now running k8s and not docker, I couldn't easily debug in docker containers,
therefor I had wrote a cronjob that creates a dev. machine every workday at specific times.
This setup included 

During the year, I created another service (NodeJS + MongoDB) and some cronjobs in k8s,
which caused my website to become unresponsive at times.
Even worse, I was also planning on using the newly enabled TCP/UDP services in v1.19 of microk8s to run a DNS and email server.
So I needed to upgrade my 2GB ram VPS to 4GB.

The easy solution would be to transfer my data to a more powerful VPS, move the IP and done.
But infrastructure architecture is kinda my hobby, so here's what I did.

## New setup

For my new server, I am migrating away from Scaleway due to their price doubling
(DEV1-S without flex IP was 2EU a month, now 4eu)
to Hetzner.
Why Hetzner; it's cheaper and has mostly similiar features like blob storage, pay per hour etc.


https://w3techs.com/technologies/comparison/ho-hetzner,ho-onlinenet
