---
title: "Terraform import when switching provider"
date: "2022-11-02"
draft: false
tags: ["terraform"]
---

For historical reasons,
we inherited a terraform setup and state file with some custom provider.
This made the code very unintuitive,
since there were two providers doing the same thing mixed together.

## Approach

1. Backup original statefile
2. Change code to new provider (this is manual and tedious)
3. Get list of items of statefile

```bash
# this requires the state to be in a clean folder, so it's not affected by the tf code
terraform state list|grep -v ^data|sort > resources-tfstate.list
cat terraform.tfstate |jq '.resources[] | select(.mode == "managed")' > managed.tfstate

while read l; do
        TYPE=`echo $l|sed 's/^\(.*\)\.\(.*\)$/\1/'`
        NAME=`echo $l|sed 's/^\(.*\)\.\(.*\)$/\2/'`
        echo "$TYPE.$NAME" # terraform import argument
        echo "cat managed.tfstate | jq 'select(.type == \"$TYPE\") | select(.name == \"$NAME\") | .instances[].attributes'"
done < resources-tfstate.list
```

4. Get list of resources defined in the code

```bash
# this needs to be run in the root of the tf code dir
grep -r '^resource\ '|grep '\.tf'|sort > resources-tf.list

# The following only works if you did terraform fmt -recursive
while read l; do
        TYPE=`echo $l|sed 's/^.*:resource "\(.*\)" "\(.*\)" {$/\1/'`
        NAME=`echo $l|sed 's/^.*:resource "\(.*\)" "\(.*\)" {$/\2/'`
        echo "$TYPE.$NAME" # terraform import argument
done < resources-tf.list
```

5. Manually map items onto each other

```bash
terraform import TYPE.NAME ENV.ID
```
