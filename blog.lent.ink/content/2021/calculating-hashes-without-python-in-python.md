---
title: "Calculating hashes in Python without Python"
date: "2021-02-06"
draft: false
tags: ["programming"]
---


The
[law of the instrument](https://en.wikipedia.org/wiki/Law_of_the_instrument)
tells us that we might not use the best tool for the job.
In this post we show an example where Python is not the tool for the job.

We created a simple script which adds the hash of a file in the filename,
enable you to detect
[data degration](https://en.wikipedia.org/wiki/Data_degradation)
for cold storage.
Note that I only use Unix systems (Linux, Android and Chromebook).

When creating the following script using Python,
you would likely first read the file into memory and then calculate a hash,
as seen in the commented part of the following script:


```python
#!/usr/bin/env python3

import os
import sys
import hashlib
import re

if len(sys.argv) == 2:
    ROOT=sys.argv[1]
else:
    ROOT="."

for root, dirs, files in os.walk(ROOT):
    for fn in files:

        fpath = os.path.join(root,fn)
        # We split on a dot (.)
        # since files can be like archive.tar.gz
        # we place the hash after the first dot
        # like archive.hashabcd1234.tar.gz
        fnlist = fn.split('.')

#        size = os.path.getsize(fpath)
#        # use either Total or Mem
#        mem_line = os.popen('free -bt|grep Total').readlines()[0]
#        free = int(mem_line.split()[3])
#        if size > int(free * 0.8):
#            print("WARNING skipping",fpath,"due to memory size",size,free)
#            continue
#
#        with open(fpath,'rb') as fpointer:
#            content = fpointer.read()
#        h = hashlib.md5(content).hexdigest()
        h = os.popen('md5sum ' + fpath).readlines()[0].split(' ')[0]

        if len(fnlist) > 2 and len(fnlist[1]) == 32 and re.match("^[0-9a-f]+$", fnlist[1]):
            if fnlist[1] != h:
                print("ERROR", fpath, "has an incorrect hash")
        else:
            hashfpath = os.path.join(root, fnlist[0] + "." + h + "." + ".".join(fnlist[1:]) )
            os.rename(fpath,hashfpath)


```

However, below the commented lines, we see the code for
[GNU's md5sum](https://man7.org/linux/man-pages/man1/md5sum.1.html),
which does not load it into memory.
The GNU utility is more efficient
and does not require you to check for the current memory available.



