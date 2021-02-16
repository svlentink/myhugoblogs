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
as seen in the following script:


```python
#!/usr/bin/env python3

import os
import sys
import hashlib
import re

REMOVE_HASH = False
arglen = len(sys.argv)
if arglen >= 2:
	if arglen == 3 and sys.argv[1].lower() == "-d":
		REMOVE_HASH = True
	ROOT=sys.argv[arglen - 1]
else:
	ROOT="."


def calc_hash_in_python(fpath):
	size = os.path.getsize(fpath)
	# use either Total or Mem
	mem_line = os.popen('free -bt|grep Total').readlines()[0]
	free = int(mem_line.split()[3])
	if size > int(free * 0.8):
		print("WARNING skipping",fpath,"due to memory size",size,free)
		return False
	
	with open(fpath,'rb') as fpointer:
		content = fpointer.read()

	return hashlib.md5(content).hexdigest()


def calc_hash_using_GNU(fpath):
	return os.popen('md5sum ' + fpath).readlines()[0].split(' ')[0]


hashes = {}
for root, dirs, files in os.walk(ROOT):
	for fn in files:

		fpath = os.path.join(root,fn)
		# We split on a dot (.)
		# since files can be like archive.tar.gz
		# we place the hash after the first dot
		# like archive.hashabcd1234.tar.gz
		fnlist = fn.split('.')

		fpath_contains_hash = ( len(fnlist) > 1 and len(fnlist[1]) == 32 and re.match("^[0-9a-f]+$", fnlist[1]) )

		if REMOVE_HASH:
			if fpath_contains_hash:
				original_path = os.path.join(root, ".".join([fnlist[0]] + fnlist[2:]) )
				os.rename(fpath, original_path)
			continue

		h = calc_hash_using_GNU(fpath)
		
		if fpath_contains_hash:
			if fnlist[1] != h:
				print("ERROR", fpath, "has an incorrect hash")
		else:
			hashfpath = os.path.join(root, ".".join([fnlist[0], h] + fnlist[1:]) )
			os.rename(fpath,hashfpath)

		if h in hashes:
			hashes[h].add(fpath)
		else:
			hashes[h] = { fpath } # new set


for v in hashes.values():
	if len(v) > 1:
		print("WARNING duplicate files",v)


```

We observe that the code using
[GNU's md5sum](https://man7.org/linux/man-pages/man1/md5sum.1.html),
does not load it into memory.
The GNU utility is more efficient
and does not require you to check for the current memory available.



