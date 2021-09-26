---
title: "Hack to enable WSL"
date: "2019-04-11"
draft: false
tags: ["Windows"]
---

Windows Subsystem for Linux (WSL) enables us to
run Linux on a Windows 10 device.
Even when developer mode and the windows store are disabled,
you can run this when you can start PowerShell
as an admin.

## Ubuntu/Debian/Kali via WSL

If we have at least windows 10 `1803` (see below),
we can install WSL using the following steps:

- Download your distro (e.g. Ubuntu) as appx [here](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
- Open PowerShell as Administrator
  - `cd  C:\Users\YOUR-USERNAME\Downloads`
  - `Add-AppxPackage .\*.Appx`
  - `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
    - Y to reboot

You are now ready to use WSL Linux.

## Container building
Docker won't work for now (we'll have to wait for WSL2),
and don't try [img](https://github.com/genuinetools/img),
it [won't](https://github.com/genuinetools/img/issues/34) work either.

## Warnings

If we cross mount a volume between Windows
and WSL,
file permissions will be changed.

If your Windows system has file backup enabled,
you want to backup to a path that is cross mounted
between the WSL and the host.
Files that once have been stored on that path
cannot be used anymore (e.g. `git commit`).
This also means that you cannot use your host tools
(e.g. IDE) and should use CLI tools (e.g. `tmux`, `vim`).

For my setup,
I tried setting up a cron job/systemd timer inside the WSL
to make a copy to the network drive mounted from the host system,
to backup my data,
which did not work.
So here is just a script which can be triggered manually:

```
cat << 'EOF' > /usr/local/bin/backup2host
#!/bin/sh

PATH2HOST=/mnt/c/Users

if [ -z "$1" ]; then
  echo Please specify to which Windows User you want to backup
  for userpath in `ls -d $PATH2HOST/* 2>/dev/null`; do
    if `stat $userpath 2>/dev/null|grep -i access|grep -q 777`; then
      echo $userpath|sed 's/.*\///g'
    fi
  done
  exit 0
fi

tar cfz "$PATH2HOST/$1/wsl-home-backup-`date --iso`.tgz" /home
EOF
chmod +x /usr/local/bin/backup2host
```


## Updating Windows

My system came with version `1709`,
which we check with `winver` inside of PowerShell.
If we upgrade to `1903` we have OpenSSH client installed by default (from `1803`).
If the update manager will not allow you to upgrade,
you can
[upgrade via the website](https://www.microsoft.com/software-download/windows10).

You can now use it by opening a shell and typing `ssh` or `scp`.

<!--

## Windows store locked

If the MS store is locked by your organization,
we need to
[manually](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
install a distro.

- Open [this link](https://aka.ms/wslubuntu2004) to download the package
- Open powershell and execute the following commands:
  - `cd C:\Users\$env:UserName\Downloads`
  - `Add-AppxPackage .\Ubuntu_2004*.appx`

-->
