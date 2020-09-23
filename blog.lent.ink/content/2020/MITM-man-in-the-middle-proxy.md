---
title: "MITM man in the middle proxy"
date: "2020-10-13"
draft: true
---

Man in the middle (MITM) proxies are use in large corporate environments.

If developers will need to download the cert insecurely, than make it available on http, thereby acklowleding that it will be downloaded insecurely,
however verify hash of file!

```
curl -o /etc/ssl/certs/MITM-proxy.crt \
  http://internal.mycompany.local/CA.crt

```

Base images for PXE and containers should already include it.
