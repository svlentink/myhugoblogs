---
title: "TMobile thuis modem router in bridge mode krijgen DrayTek 2132F"
date: "2019-08-10"
draft: false
---

Deze pagina geeft een stappen plan om je
*TMobile thuis DrayTek 2132F modem router*
te updaten. om admin te worden.
Dit is nodig om vervolgens de 
router in bridge mode te zetten.

Mijn firmware was `3.7.9.1` en DrayTek bied momenteel
`3.8.0.3` aan.

## Prerequisites

#### Eisen aan abbonement

- geen telefonie

#### Voorkennis


- [(T)FTP](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol)
- VLAN
- Indien ook [TV abbo.](https://community.t-mobile.nl/t-mobile-thuis-internet-492/draytek-router-modem-in-bridge-mode-302909
): [ICMP snooping](https://en.wikipedia.org/wiki/IGMP_snooping)?
- [NAT](https://en.wikipedia.org/wiki/Network_address_translation), waarom dit gewenst is voor [cheap IoT](https://www.slideshare.net/bz98/iot-security-is-a-nightmare) en waarom mogelijk ongewenst voor een secure NAS of cam
- IPv4 vs. IPv6 en dat IPv6 [geen NAT nodig](https://youtu.be/v26BAlfWBm8) heeft
- U snapt dat u liever een [dual stack heeft met IPv6](https://www.stipv6.nl/2019/06/stichting-ipv6-nederland-vreest-vertraging-invoering-ipv6-na-opheffen-xs4all/) dan alleen [pre-1996](https://mirrors.deepspace6.net/Linux+IPv6-HOWTO/basic-history-ipv6-linux.html) IPv4 die TMobile u nu levert



## stap 00: backup settings

- Ga naar de [web UI](http://192.168.1.1) en log in. In het midden van de pagina staat Vigor2132FVn, zoniet, ga niet verder.
- System Maintenance
- Configuration Backup
- Backup


## stap 01: flash firmware

Zie deze [bron](https://www.draytek.com/support/knowledge-base/5222) voor andere instructies,
hieronder zijn de commandos Linux (Debian) specifiek.

Kwam erachter dat mijn laptop wat automatische netwerk discovery doet,
dus heb netwerken in het menu disabled en handmatig aangezet.


- Zorg dat 1 computer verbonden is via RJ45 met port 1
- op de computer:
  - `apt install -y tftp unzip`
  - `cd ~/Downloads`
  - `unzip Vigor2132*.zip`
- Download [firmware](https://draytek.nl/downloads/firmware/) ([andere versies](http://www.draytek.com.tw/ftp/Vigor2132/Firmware/))
- zet router uit
- houd 'factory reset' ingedrukt terwijl u hem weer aanzet
- het lampje knippert nu hevig en de router is in TFTP modus
- op de computer:
  - `ip addr add 192.168.1.10/255.255.255.0 dev eth0`
  - `ip route add 192.168.1.0/24 via 192.168.1.1 dev eth0`
  - `tftp 192.168.1.1`
  - `binary`
  - `put v2132_3803.rst`


Kwam erachter dat mijn laptop wat automatische netwerk discovery doet,
dus heb netwerken in het menu disabled en handmatig aangezet
gezien file transfers mislukten.

voorbeeld input:
```
ip link set enx00e04c534458 up
ip addr add 192.168.1.10/24 dev enx00e04c534458
ip route add 192.168.1.0/24 via 192.168.1.1 dev enx00e04c534458
ping -c 1 192.168.1.1
tftp 192.168.1.1
binary
verbose
trace
status
put v2132_tw01.all
put v2132_tw01.rst
put v2132_3803.all
put v2132_3803.rst
```

voorbeeld output:
```
root@pinebook:~# apt install -y tftp unzip > /dev/null
root@pinebook:~# which tftp
/usr/bin/tftp
root@pinebook:~# cd /home/pine64/Downloads/
root@pinebook:/home/pine64/Downloads# ls *.ucb
V2132_20190810.ucb
root@pinebook:/home/pine64/Downloads# unzip Vigor2132_3803.zip 
Archive:  Vigor2132_3803.zip
  inflating: v2132_3803.all          
  inflating: v2132_3803.rst          
  inflating: Readme.txt
root@pinebook:/home/pine64/Downloads# unzip Vigor2132_v3.7.9_TW.zip 
Archive:  Vigor2132_v3.7.9_TW.zip
  inflating: v2132_tw01.all          
  inflating: v2132_tw01.rst


root@pinebook:/home/pine64/Downloads# ip link set enx00e04c534458 up
root@pinebook:/home/pine64/Downloads# ip addr add 192.168.1.10/24 dev enx00e04c534458
RTNETLINK answers: File exists
root@pinebook:/home/pine64/Downloads# ip route add 192.168.1.0/24 via 192.168.1.1 dev enx00e04c534458
RTNETLINK answers: File exists
root@pinebook:/home/pine64/Downloads# ping -c 1 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=255 time=0.795 ms

--- 192.168.1.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.795/0.795/0.795/0.000 ms
root@pinebook:/home/pine64/Downloads# tftp 192.168.1.1
tftp> binary
tftp> verbose
Verbose mode on.
tftp> put v2132_3803.rst
putting v2132_3803.rst to 192.168.1.1:v2132_3803.rst [octet]
Sent 8393464 bytes in 26.9 seconds [2496197 bits/sec]
tftp> root@pinebook:/home/pine64/Downloads# ls -al v2132_3803.rst
-rw-r--r-- 1 root root 8393464 Dec 18  2018 v2132_3803.rst

```

## stap 02: configuratie

[bron](https://community.t-mobile.nl/t-mobile-thuis-algemeen-490/je-eigen-modem-bij-t-mobile-thuis-307241)

Als de vorige stap heeft gewerkt,
dan moet de router na het uploaden van de firmware (v2132_3803.rst) geupdate zijn.

Echter staat er in de
[release notes](https://draytek.nl/files/Vigor2132_3803_Releasenotes.pdf)
van de laatste versie:
*use the latest boot-loader, or need to upgrade 3752_B1 (ask your dealer) first*,
iets waar
[anderen](https://community.t-mobile.nl/t-mobile-thuis-algemeen-490/update-proces-router-vigor2132fvn-vraagt-om-the-latest-boot-loader-or-need-to-upgrade-3752-b1-ask-your-dealer-first-hoe-krijg-ik-die-in-mijn-bezit-310929)
ook al achter waren gekomen.

Heb ook nog andere namen geprobeerd,
om te kijken of de huidige versie (die dus geen upgrade nodig heeft) wel werkt als de naam opgehoogd is:
```
cp v2132_tw01.rst v2132_3792.rst
cp v2132_tw01.rst v2132_zz99.rst

put v2132_3792.rst
put v2132_zz99.rst
```
maar dit werkt ook niet.

Maar er is nog wel
[hoop](https://community.t-mobile.nl/t-mobile-thuis-algemeen-490/loaden-eigen-firmware-draytek-276649)...

```
git clone https://github.com/tjcomserv/draytools
cp V2132_20190809.ucb draytools/
docker run -it --rm -v $PWD/draytools:/repo --entrypoint bash python:2.7
root@cd7b972ae810:/# cd /repo/
root@cd7b972ae810:/repo# python draytools.py -vc V2132_20190809.ucb 
File is  :      compressed, encrypted (new)
Model is :      V2132
13f9e73e692b254f7c431a38c3340ee9

13f9e73e692b254f
0x2B254F69
0x13E73EF9
0x13E73EF9
0xEC18C106

Encrypted:      0xAA10F1BB

Decrypted:      0x0764C084
Plaintext:      0x07030000
fail
```

Het is dus wel mogelijk..
maar de exacte details zou ik hier niet mogen plaatsen.

Mocht de lezer van dit stuk het watchwoord ook gevonden hebben,
laat het me dan weten, ben benieuwd of het een universeel wachtwoord is,
of wij beiden hetzelfde hebben.

## Weetjes

#### Andere manier om eigen router te gebruiken

Mocht de twijfel toeslaan,
niet je TMobile router willen 'slopen',
dan kunt u ook uw
[eigen router](https://mikrotik.com/product/RB2011UiAS-2HnD-IN) gebruiken als die een sfp ingang heeft.
Ook kunt u een
[media converter](https://www.aliexpress.com/wholesale?switch_new_app=y&SearchText=sfp+converter)
en de huidige sfp gebruiken.
Aan deze *media converter* kunt u direct uw apparatuur aansluiten,
zoals een managed switch (L2) met VLAN ondersteuning.
*Goed om te weten; veel kleine switches (zoals
[Netgear](https://kb.netgear.com/30915/How-to-discover-a-ProSAFE-Web-Managed-Plus-Switch)
en
[TP-Link](https://www.tp-link.com/us/support/download/tl-sg105e/#Unmanaged_Pro_Configuration_Utility))
hadden als eis dat je
[software op een Windows PC installeert](https://serverfault.com/questions/361535/netgear-gs108e-switch-requires-external-management-software)
om de switch in te kunnen stellen.*

Routers (L3) hebben vaak een web interface, dus geen software nodig op PC, alleen een browser.
L2 doet frame forwarding
en L3 doet packet routing en heeft vaak een default gateway, waar ze vaak op poort 80 luisteren met een web UI.
Moderne L2 managed switches hebben wel
"*[management via a web user interface](https://www.tp-link.com/us/business-networking/easy-smart-switch/tl-sg105e/)*".

De web UI van de L3 DrayTek is te vinden op [192.168.1.1](http://192.168.1.1),
wat tevens de default gateway is.

#### default gateway address

DrayTek maakt standaard gebruik van `192.168.1.1` als default gateway/web UI adres,
maar u kunt ook een ander
[prive netwerk](https://en.wikipedia.org/wiki/Private_network)
kiezen en `10.10.10.10` als default gateway instellen (makkelijker te onthouden).

#### eigen router maken

Mocht U een
[eigen router](https://w1.fi/hostapd/)
willen maken,
bv. met een
[Raspberry Pi 4](https://www.raspberrypi.org/magpi/raspberry-pi-4-specs-benchmarks/),
dan kunt u ook gaan voor een *sfp USB3.0 dongle*.
Dit maakt het mogelijk om zelf een *dual stack* in te richten met de
`[2002:a.b.c.d::/48](https://en.wikipedia.org/wiki/6to4)` range,
waar `a.b.c.d` het door de ISP uitgegeven DHCP IPv4 is.

Maar als u zelfbouw wilt heeft u weinig opgestoken van deze pagina
en snapt u ook dat NAT in software langzamer is dan NAT in hardware.

Als niks voldoet kun je altijd nog je eigen
[ASICs inregelen](https://p4.org/p4/clarifying-the-differences-between-p4-and-openflow.html).
