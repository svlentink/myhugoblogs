---
title: "DIY NAS Network Attached Storage from USB stick"
date: "2019-09-28"
draft: false
tags: ["DIY"]
---

This post shows how to use a USB stick/HDD in a Linux device as NAS or Network Attached Storage
using Samba, the protocol available on Chromebooks and Windows devices.
NAS servers allow the IT guy in the house/office to manage the backups for others.

What we need is an USB stick/HDD and a device to insert it into.
My router has the option,
but I'll show how to use a
[SoC](https://blog.lent.ink/post/diy-cheatsheet/)
(Raspberry pi) instead,
since it's a bit more complicated.

If the disk is formatted as NTFS:

```sh
apt install -y ntfs-3g
```

now plugin the device in your Raspberry Pi.

Next we play around to find the correct partition and mount it:
```sh
fdisk -l

root@OrangePI:~# lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 465.8G  0 disk 
└─sda1        8:1    0 465.8G  0 part 
mmcblk0     179:0    0   1.9G  0 disk 
├─mmcblk0p1 179:1    0    64M  0 part /media/boot
└─mmcblk0p2 179:2    0   1.8G  0 part /
root@OrangePI:~# mkdir -p /media/usbhdd
root@OrangePI:~# mount /dev/sda1 /media/usbhdd                                       
root@OrangePI:~# fdisk -l|grep dev
Disk /dev/sda: 500.1 GB, 500107862016 bytes
/dev/sda1   *          63   976768064   488384001    7  HPFS/NTFS/exFAT
Disk /dev/mmcblk0: 2032 MB, 2032664576 bytes
/dev/mmcblk0p1           40960      172031       65536    b  W95 FAT32
/dev/mmcblk0p2          172032     3969024     1898496+  83  Linux
root@OrangePI:~# tail -1 /proc/mounts
/dev/sda1 /media/usbhdd fuseblk rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,blksize=4096 0 0

```

We could make it reboot persistent by:

```sh
echo "/dev/sba1 /media/usbhdd auto defaults 0 0" >> /etc/fstab
```
but making a mistake could prevent the system from booting...

We have the disk now connected and visible on the SoC.
One can now decide to share it as a NAS using a
web portal (e.g. nextcloud), NFS or Samba.

We use Samba since chromebooks
support this Windows protocol by default.
*Which is odd, since chromeos runs on a Linux kernel, so NFS would be expected...*

Install
[Samba](https://tutorials.ubuntu.com/tutorial/install-and-configure-samba):

```sh
apt install -y samba

cat << EOF >> /etc/samba/smb.conf
[usbhdd]
    comment = USB hdd on orangepi
    path = /media/usbhdd
    read only = no
    browsable = yes
EOF

service smbd restart
smbpasswd -a $USER
```

We can now add it to all our devices.
The manual for Chromebooks can be found
[here](https://support.google.com/chromebook?p=network_file_shares&b=edgar-signed-mp-v2keys).

```
\\192.168.1.110\usbhdd
```

