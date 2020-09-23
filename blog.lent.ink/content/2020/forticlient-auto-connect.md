---
title: "Overcoming FortiClient shortcomings"
date: "2020-10-13"
draft: true
---

The FortiClient VPN has the option to do auto connect in the payed version of the app.
In the free version, I usually need to connect two times, since the first one seems to fail every time.
This would make sense given their business model;
make the app fail almost every first time so users get frustrated and do the upsell to auto connect.
However, this does not apply to me, it makes me value the product less and less likely to pay for it.

Since the VPN might be needed for communication channels and you don't want to be offline all the time,
I suggest the following powershell script:

```powershell
while($true){
  if (Resolve-DnsName some-dns.only-resolvable-when.on.vpn) {
  	echo "Connected at $(date)"
  	Start-Sleep -s 5
  } else {
  	& 'C:\Program Files\FortiClient\Forticlient.exe'
  	Start-Sleep -s 120
  }
}
```

It monitors if your Windows machine can resolve a DNS hostname from a DNS server that is only accessable via the VPN.
If this fails, it promps you with the VPN connection screen.
On Linux I would automate it via some CLI based tool, but on Windows,
this is the best I could find (without admin rights).

