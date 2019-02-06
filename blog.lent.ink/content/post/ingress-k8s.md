---
title: "Expose Nginx to public in Kubernetes"
date: "2019-02-06"
draft: false
tags: ["kubernetes"]
---

After getting kubernetes up and running and
[the dashboard online](https://blog.lent.ink/post/kubectl-proxy-basic-auth/)
we proceed to getting our first service public to the world.

When you do not use a load balancer provided by your cloud provider,
kubernetes offers you two options for exposing ports:
`NodePort` or using an `ingress`.
Ingress is clearly the way to go,
enabling you to have multiple services using the same port
([this](https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-ingress-guide-nginx-example.html)
article explains the difference in more detail).


## Exposing Nginx using Ingress

Make sure you have `ingress` enabled.
If you installed `microk8s` you can do the following:
```shell
microk8s.enable ingress
```

Next we can create our configuration:
```yaml
---
# https://kubernetes.io/docs/concepts/services-networking/ingress/
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: http-ingress
spec:
  backend:
    serviceName: mainservice
    servicePort: 80
---
# https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cdn
spec:
  selector:
    matchLabels:
      appservgroup: mainserv
  replicas: 1
  template: # create pods; pod template
    metadata:
      labels:
        appservgroup: mainserv
    spec:
      containers:
      - name: cdn
        image: nginx:alpine
        ports:
        - containerPort: 80
---
# https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#exposing-pods-to-the-cluster
apiVersion: v1
kind: Service
metadata:
  name: mainservice
  namespace: default
#  labels:
#    exposelabelexample: http
spec:
#  type: NodePort
  ports:
  - name: http
    port: 80
#    protocol: TCP # default = TCP
#    targetPort: 80 # you can skip this if it's the same as port
  selector:
    appservgroup: mainserv

```
which we save as `boilerplate.yml`

This boilerplate contains three yaml files,
which we combined and separated with `---`.

If we now start this:
```shell
kubectl create -f boilerplate.yml
```
we can view it in our dashboard (select all namespaces visible).
And it should be publicly accessible when it has been started.

To stop and remove use the same configuration file:
```shell
kubectl delete -f boilerplate.yml
```

Please see the kubernetes documentation
[about ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#simple-fanout)
for more detailed examples using hosts and paths.

