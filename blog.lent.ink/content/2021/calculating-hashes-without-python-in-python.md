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
	if '"' in fpath or "`" in fpath:
		raise Exception("ERROR filepath contains quotes",fpath)
	return os.popen(f"md5sum \"{fpath}\"").readlines()[0].split(' ')[0]


def get_hash_filename(root, fn, h=None):
	hash_name = None
	hash_from_fn = None

	# We split on a dot (.)
	# since files can be like archive.tar.gz
	# we place the hash after the first dot
	# like archive.hashabcd1234.tar.gz
	fnlist = fn.split('.')

	contains_hash = ( len(fnlist) > 1 and len(fnlist[1]) == 32 and re.match("^[0-9a-f]+$", fnlist[1]) )

	if contains_hash:
		hash_from_fn = fnlist[1]
		if h and hash_from_fn != h:
			raise Exception("Hash in filename and function arg do not match",hash_from_fn,h,root,fn)
		h = hash_from_fn
		hash_name = fn
		original_name = ".".join([fnlist[0]] + fnlist[2:])
	else:
		if h:
			hash_name = ".".join([fnlist[0], h] + fnlist[1:])
		original_name = fn

	result = {
		"original_fname": original_name,
		"original_fpath": os.path.join(root, original_name),
	}
	if h:
		result.update({
			"hash": h,
			"hash_fname": hash_name,
			"hash_fpath": os.path.join(root, hash_name),
		})
	return result
		

hashes = {}
for root, dirs, files in os.walk(ROOT):
	for fn in files:
		fpath = os.path.join(root,fn)
		if os.path.islink(fpath) or not os.path.isfile(fpath):
			continue

		nameobj = get_hash_filename(root, fn)

		if REMOVE_HASH:
			if "hash" in nameobj:
				os.rename( nameobj['hash_fpath'], nameobj['original_fpath'] )
			continue

		h = calc_hash_using_GNU(fpath)
		
		if "hash" in nameobj:
			if nameobj["hash"] != h:
				print("ERROR", fpath, "has an incorrect hash")
		else:
			# Thus fpath == nameobj["original_fpath"]
			nameobj = get_hash_filename(root, fn, h)
			os.rename( nameobj["original_fpath"], nameobj["hash_fpath"] )

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



