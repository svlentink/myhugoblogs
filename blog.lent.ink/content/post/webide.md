---
title: "List of self hosted web based IDEs"
date: "2019-02-10"
draft: false
tags: ["coding"]
---


Developers write code in an integrated development environment (IDE),
which is usually installed on their workstation.
A WebIDE runs in the cloud,
allowing one to work from any device that has a browser.
In this article we only consider open source products.

I've used a WebIDE for more than a year now and love it.
It has allowed me to use a chromebook now and do everything in the cloud.

Let's start with my current IDE,
ACE/Cloud9,
which became part of
[AWS](https://c9.io/announcement)
making it likely to be maintained.

| Editor | Backend | Stars | Last commit |
| --- | --- | --- | --- |
| [ACE/Cloud9](https://github.com/ajaxorg/ace) | Node.js | 19148 | Feb 4, 2019 |
_star count and dates added on 2019/02/10_

My search continued.
I needed a simple IDE to allow people (non-tech)
to edit Markdown files and upload pictures for a static blog/website generator.

## Lightweight WebIDE

Options I found were:

| Editor | Backend | Stars | Last commit | Comments |
| --- | --- | --- | --- | --- |
| [Codiad](https://github.com/Codiad/Codiad) | PHP | 2504 | Oct 31, 2018 | unmaintained |
| [ICEcoder](https://github.com/icecoder/ICEcoder) | PHP | 1038 | Dec 14, 2018 |
| [Eclipse orion.client](https://github.com/eclipse/orion.client) | Node.js | 175 | Feb 7, 2019 |

About one we read:
_Codiad is a web-based IDE framework with a small footprint and minimal requirements._
which I
[tried](https://github.com/svlentink/dockerfiles/tree/master/docker-compose/codiad)
and gave a good first impression.
Orion gave errors on
[my setup](https://github.com/svlentink/dockerfiles/tree/master/svlentink/orion.client).

## Heavyweight WebIDE

If you want a great WebIDE and
[system requirements](https://stackoverflow.com/questions/35940051/how-much-hardware-resources-needs-an-eclipse-che-host-guest-vm)
aren't and issue,
I would try out Eclipse Che.

| Editor | Backend | Stars | Last commit |
| --- | --- | --- | --- |
| [Eclipse Che](https://github.com/eclipse/che) | Java | 5304 | Feb 9, 2019 |

## Other WebIDEs

Others I found but were not for me:

| Editor | Stars | Last commit | Comments |
| --- | --- | --- | --- | 
| [Phosphorus Five](https://github.com/polterguy/phosphorusfive) | 163 | Jul 15, 2018 | C# |
| [ShiftEdit](https://github.com/adamjimenez/shiftedit) | 81 | Sep 4, 2018 | not mature |
| [Atom in Orbit](https://github.com/facebook-atom/atom-in-orbit) | 1190 | Dec 1, 2016 | unmaintained |
| [codebox](https://github.com/CodeboxIDE/codebox) | 3934 | Apr 23, 2015 | unmaintained |
| [Codenvy](https://github.com/codenvy/codenvy) | 221 | Feb 13, 2018 | Java |
| [Coding WebIDE](https://github.com/Coding/WebIDE) | 1081 | Aug 23, 2018 | Java, Chinese code |
| [Filebrowser](https://github.com/filebrowser/filebrowser) | 4326 | Feb 8, 2019 | unmaintained |

Filebrowser was suggested by
[Hugo](https://gohugo.io/tools/frontends/)
but this should be ignored now.
Got the setup
[working](https://hub.docker.com/r/svlentink/filebrowser-hugo)
in the past but recent builds fail,
the filebrowser code base was a mess.

NOTE: we do not consider Gitlab (self hosted Git) a WebIDE,
but it can serve as a webportal to edit files.
NextCloud and other
[Web File Managers](https://github.com/Kickball/awesome-selfhosted#web-based-file-managers)
can provide similar features.

NOTE: Now in 2020,
there are
[more](https://github.com/awesome-selfhosted/awesome-selfhosted/blob/master/README.md#idetools)
awesome editors such as
[VS in browser](https://github.com/cdr/code-server).
