---
title: "Microk8s cert-manager issue"
date: "2021-03-15"
draft: false
---

After migrating my server, microk8s had been updated,
as well as cert-manager.
This gave some errors:

```
"msg"="propagation check failed" "error"="wrong status code '404', expected '200'"
```

Initially I thought the issue was between a version mismatch,
but when my nginx based service wasn't working either I found:

```
kubectl logs -n ingress nginx-ingress-microk8s-controller-*|grep annotation
I0315 15:33:07.280902       6 store.go:363] ignoring add for ingress REDACTED based on annotation kubernetes.io/ingress.class with value 
I0315 15:39:55.955968       6 store.go:338] ignoring delete for ingress REDACTED based on annotation kubernetes.io/ingress.class
```

This annotation is mentioned on the ingress page of kubernetes and is
[mentioned as a deprecated](https://kubernetes.io/docs/concepts/services-networking/ingress/#deprecated-annotation)
option.
However, it is still actively used in cert-manager.

To fix it, see
[this](https://github.com/svlentink/myinfra/blob/master/scripts/cert-manager.sh)
script.

