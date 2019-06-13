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
ssl_prefer_server_ciphers on;
```

Note that this will not work for older browsers
like Edge and IE.
Chrome works fine.

## Debugging OpenSSL

If you get an error stating `no cipher match`
your Nginx may not have the latest
[OpenSSL](https://www.openssl.org/docs/man1.1.1/man1/ciphers.html)
version.
```
FROM nginx:alpine
RUN apk add --no-cache openssl
# https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile

# we get into the container and verify:
/ # nginx -V 2>&1|grep Open
built with OpenSSL 1.1.1b  26 Feb 2019
/ # openssl version
OpenSSL 1.1.1b  26 Feb 2019
/ # openssl ciphers
TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256 ...


/ # openssl ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:ECDHE-ECDSA-AES256-GCM-SHA384'
TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:ECDHE-ECDSA-AES256-GCM-SHA384

/ # openssl ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256'
Error in cipher list
140610538539880:error:1410D0B9:SSL routines:SSL_CTX_set_cipher_list:no cipher match:ssl/ssl_lib.c:2549:

/ # openssl ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:PSK-CAMELLIA128-SHA256'
TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256:PSK-CAMELLIA128-SHA256

/ # openssl ciphers -s -tls1_3
TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256
/ # openssl ciphers -V|grep SSL|tail -3
          0x00,0x90 - DHE-PSK-AES128-CBC-SHA  SSLv3 Kx=DHEPSK   Au=PSK  Enc=AES(128)  Mac=SHA1
          0x00,0x2F - AES128-SHA              SSLv3 Kx=RSA      Au=RSA  Enc=AES(128)  Mac=SHA1
          0x00,0x8C - PSK-AES128-CBC-SHA      SSLv3 Kx=PSK      Au=PSK  Enc=AES(128)  Mac=SHA1
```

This topic still needs some attention.
I assume that if you enable TLS1.3 on one domain
and not on others,
the client will negotiate TLS1.3 before stating the SNI (which will be encrypted),
resulting in all TLS1.3 traffic being handled by the single `server_name`.
Therefor, if one of the virtual servers contains TLS1.3,
all need it specified.


#### Update

We can read
[here](https://serverfault.com/questions/704376/disable-tls-1-0-in-nginx)
that Nginx does not allow for specific TLS versions for different virtual hosts,
tried this with shared certificate and non overlapping certificates,
it did not work.
Maybe HAProxy does first check the SNI before telling what it accepts,
I'll check that one later.

