---
title: "Retrieve DrayTek password"
date: "2020-05-18"
draft: true
tags: ["hacking"]
---

Since I got multiple requests for the password,
here we go:

- Login on your draytek at 192.168.1.1
  - Copy the MAC address found on the first page
  - Get backup: System Maintenance, Configuration Backup, Backup
- Do something similar on a GNU/Linux shell:

```shell
cd /tmp
git clone https://github.com/tjcomserv/draytools
cp V2132_20*.ucb draytools/ # copy your backup

docker run -it --rm \
  -v $PWD/draytools:/repo \
  -w /repo \
  --entrypoint bash \
  python:2.7

# Following is inside container,
# since I dont trust the code on my bare machine

# use MAC address of router
python draytools.py -m 00-1D-AA-12-34-56 V2132_20*.ucb 
Username  :     admin
Master key:     PkKeMzRn
```

echo 00-1D-AA-E8-7F-58