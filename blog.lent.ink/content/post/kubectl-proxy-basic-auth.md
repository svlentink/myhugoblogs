---
title: "Kubernetes dashboard basic auth"
date: "2019-02-03"
draft: false
tags: ["kubernetes"]
---

Kubernetes provides us with a proxy
without TLS support or HTTP Basic authentication (BA).
Using IP filtering (`--accept-hosts`) did not work on my VPS either.
In this post I'll show how you can access your dashboard with TLS and basic auth.

This post can also be used to get your first k8s running on your Ubuntu machine/VPS.


## Get your cluster

The following steps are based on
[this](https://tutorials.ubuntu.com/tutorial/install-a-local-kubernetes-with-microk8s)
tutorial.

You should have Ubuntu 16 or higher:
```
root@k8s:~# cat /etc/issue
Ubuntu 18.04.1 LTS \n \l
```

If you don't have a k8s cluster, you could use the following:
```shell
apt update
apt upgrade -y
snap install microk8s --classic
sleep 120
microk8s.start
microk8s.status
which kubectl || snap alias microk8s.kubectl kubectl
```

## Dashboard running

Make sure you have a dashboard running:
```shell
microk8s.enable dashboard dns
sleep 120
kubectl get all --all-namespaces
kubectl cluster-info
```

You can now test if you can access your dashboard via the default proxy:
```shell
# WARNING this is NOT secure!
kubectl proxy --address=0.0.0.0 --accept-hosts='^.*$'
```
which will launch it on `YOUR_IP:8001`
- `/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy`
- `/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy`

WARNING this is open to the world!
So please kill the `kubectl proxy` or don't run it in the first place like this.

## Basic auth

Instead of using `kubectl` as a proxy, we'll use Nginx.
The following code is based on
[this](https://hub.docker.com/r/svlentink/ipfilter)
docker container:

```shell
#!/bin/sh

CONFIG=/etc/nginx/sites-available/default
FILTERCONF=/nginx-filter-options.conf

cat << EOF > $CONFIG
upstream app_upstream {
  server 127.0.0.1:8080;
}
server {
  listen 8001      ssl http2 default_server;
  listen [::]:8001 ssl http2 default_server;
  server_name _;

  ssl_certificate     /selfsigned.crt;
  ssl_certificate_key /selfsigned.key;
  ssl_dhparam         /dhparam.pem;
  
  ssl_protocols TLSv1.2;
  add_header X-Frame-Options DENY;
  
  include /nginx-filter-options.conf;

  location / {
    proxy_pass http://app_upstream;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }
}

EOF


> $FILTERCONF
if [ -n "$ALLOWED_IPS" ];then
  echo ALLOWED_IPS is set
  for iprange in $ALLOWED_IPS; do
    echo "allow $iprange;" >> $FILTERCONF
  done
  echo "deny all;" >> $FILTERCONF
fi
if [ -n "$AUTH_PASS" ]; then
  echo Using basic auth
  echo 'auth_basic "closed site"; auth_basic_user_file /.htpasswd;' \
  >> $FILTERCONF
  if [ -z "$AUTH_USER" ]; then
    AUTH_USER=admin
  fi
  echo -n $AUTH_USER':' > /.htpasswd
  openssl passwd -apr1 "$AUTH_PASS" >> /.htpasswd
fi

echo BEGIN content of nginx filter
cat /nginx-filter-options.conf
echo END content of nginx filter

genCert () {
  openssl req -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /selfsigned.key \
  -out /selfsigned.crt \
  -batch \
  -subj "/C=NL/ST=NoordHolland/L=Amsterdam/O=Unknown/OU=Development/CN=www.lent.ink"
  
  openssl dhparam \
  -out /dhparam.pem \
  1024
}

if ! [ -f /dhparam.pem ]; then
  genCert
  echo DONE generating cert.
fi

nginx -s reload

```
which we save as `script.sh`.

Then we do:
```shell
export AUTH_PASS=yoursecret
export AUTH_USER=admin
bash script.sh
```

You can now visit the dashboard path,
where you need to accept the self generated certificate,
after which you need to login with basic auth.
