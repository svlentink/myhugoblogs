---
title: "Home automation through device detection using MAC address"
date: "2019-12-28"
draft: false
tags: ["DIY"]
---

There are multiple ways of controlling home automation.
This blog introduces another sensor to the network;
detecting if someone is home through testing if the MAC address is present on the L2 network.

## Ping to MAC address

The basis for our script will be:

```shell
sudo su
apt install -y arp-scan

arp-scan --destaddr=04:b1:67:aa:bb:cc \
  --localnet \
  --interface="`iw dev|grep -o wlan[0-9]|head -1`" \
  | grep '1 responded'
```

The last command tests if the hardware address of the interface (e.g. smartphone)
is present on the network.
This can then be used to control the heater or some other home automation.

## Status script

We now present the script that allows us to verify if the device is connected to the WiFi network.
The `arp-scan` in our example uses the wireless interface.
You may want to use `eth0`.

```shell
sudo su
apt install -y arp-scan

cat << 'EOF' > /usr/local/bin/update-mac-status.sh
#!/bin/sh

if [ -z "$1" ]; then
  echo please provide a mac address to this script
  exit 1
fi

mkdir -p /var/log/mac-status
if [ ! -f /run/"$1" ]; then
  echo 0 > /run/"$1"
fi

if arp-scan --destaddr="$1" \
  --localnet \
  --interface="`/sbin/iw dev|grep -o wlan[0-9]|head -1`" \
  | grep -q '1 responded'; then
  if grep -q 0 /run/"$1"; then
    echo 1 > /run/"$1"
    echo -n '1 '   >> /var/log/mac-status/"$1"
    date --iso=min >> /var/log/mac-status/"$1"
  fi
else
  if grep -q 1 /run/"$1"; then
    echo 0 > /run/"$1"
    echo -n '0 '   >> /var/log/mac-status/"$1"
    date --iso=min >> /var/log/mac-status/"$1"
  fi
fi

EOF
chmod +x /usr/local/bin/update-mac-status.sh
```

## Check multiple

The following script accepts a list of MAC addresses and lets you know if anyone is home.

```shell
cat << 'EOF' > /usr/local/bin/anybody-home.sh
#!/bin/sh

if [ -z "$1" ]; then
  echo please provide one or more MAC addresses
  exit 1
fi

for i in $@; do
  /usr/local/bin/update-mac-status.sh "$i"
done

for i in $@; do
  grep -q 1 /run/"$i" && echo 1 && exit 0
done

# when no one is home
echo 0
exit 0
EOF
chmod +x /usr/local/bin/anybody-home.sh
```

## Using it

We build upon the example found in a
[previous](/post/diy-cheatsheet/) post.
The following shows an example `cron.d` file:

```shell
# check if home
*/3 * * * * root /usr/local/bin/anybody-home.sh F4-60-E2-AA-BB-CC 04:b1:67:aa:bb:cc > /run/someone-home

# turn on during these times
30 16 * * * root echo 1 > /run/relay

# turn off during these times
45 6,21,23 * * * root echo 0 > /run/relay

# during the following hours
# the heater will turn on when someone home
# and off when not at home
* 5,8-15,18-20 * * * root cp /run/someone-home /run/relay

# set state
* * * * * root /usr/local/bin/set-relay.py `cat /run/relay`
```

## Conclude

We showed how one can use the hardware (MAC) address of the WiFi interface
of smartphones to detect if people are at home.
We used this in our home automation to control the heater.
