---
title: 'Development Environment on WSL or Crostini'
date: '2025-03-14'
draft: true
tags: ['WSL', 'Chromebook']
---

Development on a Windows laptop or Chromebook works quite well,
as long as you use the build in Linux shell.

Here is my cheatsheet for installing all the tools on your Ubuntu/Debian shell.

```
wsl --install Ubuntu
wsl -d Ubuntu
sudo su
```

```
apt update
apt dist-upgrade -y
apt install -y \
    git tmux
    dnsutils iputils-ping
    python3-dev python3-pip pipx
    podman

pipx install --include-deps ansible

git config --global user.email 'me@domain.com'
git config --global user.name 'YOUR_NAME'

cat << EOF > ~/ide.yml
apiVersion: v1
kind: Pod
metadata:
  name: ide
spec:
  containers:
  - name: ide
    args:
    - "--auth"
    - "none"
    image: docker.io/svlentink/code-server #codercom/code-server
    securityContext:
        runAsUser: 0
    ports:
    - containerPort: 8080
      hostPort: 8080
      protocol: TCP
    volumeMounts:
    - mountPath: /home/coder/stateful
      name: stateful
    - mountPath: /root/.gitconfig
      name: gitconf
    - mountPath: /root/.ssh
      name: ssh
  volumes:
  - hostPath:
      path: /mnt/stateful
      type: DirectoryOrCreate
    name: stateful
  - name: gitconf
    hostPath:
      path: /mnt/.gitconfig
      type: FileOrCreate
  - hostPath:
      path: /mnt/.ssh
      type: DirectoryOrCreate
    name: ssh

EOF
```
