---
title: "Prevent MITM proxies"
date: "2019-04-10"
draft: false
tags: ["Security"]
---

Men In The Middle (MITM) proxies are used in some
corporate environments for compliancy.
You can spot this in your browser by inspecting
the certificate.

Sometimes you don't want people to be able to
do eavesdropping, which we can prevent using Nginx.

Use the following config:
```
ssl_protocols TLSv1.3;
ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-256-GCM-SHA384:TLS13-AES-128-GCM-SHA256;
ssl_prefer_server_ciphers on;
```

Note that this will not work for older browsers
like Edge and IE.
Chrome works fine.

