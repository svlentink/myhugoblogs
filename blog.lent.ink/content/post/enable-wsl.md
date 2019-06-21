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

## SSH client

My system came with version `1709`,
which we check with `winver` inside of PowerShell.
If we upgrade to `1809` we have OpenSSH client installed by default.
If the update manager will not allow you to upgrade,
you can
[upgrade via the website](https://www.microsoft.com/software-download/windows10).

You can now use it by first opening a shell and typing `ssh`.

## Ubuntu/Debian/Kali via WSL

After updating our system has the latest version,
we install WSL.

- Open Settings, search for Developer and select 'Sideload Apps'
- Download your distro (e.g. Ubuntu) as appx [here](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
- Open PowerShell as Administrator
- `cd  C:\Users\YOUR-USERNAME\Downloads`
- `Add-AppxPackage .\*.Appx`


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
(e.g. IDE) and should use CLI tools (e.g. tmux, vim).

For my setup,
I tried setting up a cron job/systemd timer inside the WSL
to make a copy to the network drive mounted from the host system,
to backup my data,
which did not work.
So here is just a script which can be triggered manually:

```
cat << EOF > /usr/local/bin/backup2host
#!/bin/sh
cp -r /home/* /mnt/c/Users/YOUR-USERNAME/Documents/
EOF
chmod +x /usr/local/bin/backup2host
```

You should tar the data if you want to preserve
your file permissions in your backup.
