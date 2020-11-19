---
title: "Grafana Toml to environment variables"
date: "2020-11-19"
draft: true
tags: ["coding"]
---

The following snippet creates
[environment variables](https://grafana.com/docs/grafana/latest/administration/configuration/#configure-with-environment-variables)
from your Grafana toml.

```shell
#!/bin/sh

# Script writes to env file and shows JSON lines on stdout

if [ -z "$2" ]; then
	echo "USAGE: $0 ./inputfile.toml ./output.env"
fi

TF=/tmp/temp-grafana-conf.toml
echo "[default]" > $TF
cat $1 >> $TF
> $2

while read l; do
	if `echo $l|grep -q '^#'`; then
		continue
	fi
	if `echo $l|grep -q '^\[.*\]$'`; then
		PREFIX=`echo $l|tr -d '\[\]'`
		continue
	fi
	if `echo $l|grep -q '='`; then
		NAME="GF_$PREFIX"
		NAME=$NAME"_`echo $l|awk '{print $1}'`"
		NAME=`echo $NAME|tr a-z\.\- A-Z__`
		VAL=`echo $l|sed 's/^.*\ =\ //'`
		echo "export $NAME=$VAL" >> $2
		echo "\"$NAME\": \"$VAL\","
		continue
	fi
done < $TF
```

The script isn't perfect (arrays and mid line comments will fail) but it'll save you some manual work.

