---
title: "An introduction to coding: converting excel (csv) to markdown table"
date: "2019-09-30"
draft: false
tags: ["coding"]
---

So you know your way around your OS (operating system) a bit,
you use your terminal/CLI (command line interface) more and more
and want to start coding?
This post explores how you can get on your way becoming a programmer
during your normal desk job.

## CLI

We encourage you to use a Unix CLI more and more,
on Windows I would recommend
[WSL](https://blog.lent.ink/post/enable-wsl/),
on OSx, Linux and
[Chromebooks](https://support.google.com/chromebook/answer/9145439)
it comes pre-installed.

Using the CLI changes the way you look at your directory structure
and helps you get familiar with GNU tools that can be used to create scripts.

Many universities teach students to use a visual editor
to create scripts and run them via the UI (e.g.
[Jupyter](https://github.com/svlentink/fods_uc1/blob/master/docker-compose.yml)),
but you will need the CLI skills when interacting with a server over SSH.

## Finding problems

Software is the act of manipulating data.
To find relevant use cases during our daily work,
we turn to simple examples in which we want to manipulate data.

Examples are:

- file conversions
- file manipulations
- data filtering/reduction

Let's start exploring them.

## Data filtering

We first show the example
and then explain it:

```sh
svlentink@penguin:~$ curl --http2 -Iv https://lent.ink 2>&1|grep -i http
* Rebuilt URL to: https://lent.ink/
* ALPN, offering http/1.1
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
> HEAD / HTTP/1.1
< HTTP/2 200 
* Curl_http_done: called premature == 0
HTTP/2 200 
svlentink@penguin:~$ curl --http1.1 -Iv https://lent.ink 2>&1|grep -i http
* Rebuilt URL to: https://lent.ink/
* ALPN, offering http/1.1
* ALPN, server accepted to use http/1.1
> HEAD / HTTP/1.1
< HTTP/1.1 200 OK
* Curl_http_done: called premature == 0
HTTP/1.1 200 OK
```

We did two HTTP HEAD request (`-I`) which we inspected using verbose output (`-v`).
This output we pipe into `grep`, a tool that allows us to get lines with specific keywords.
We match case insensitive (`-i`).

## File manipulation

Please run the following commands on your Unix terminal:

```sh
echo 'value=true' > /tmp/myconfig.conf
sed -i 's/value=/value=false\ #/g' /tmp/myconfig.conf
cat /tmp/myconfig.conf
```

We created a file,
changed the boolean value and perserved the original value
by making it a comment.
Then we showed the output using `cat`.
To know more about `sed`, just do `man sed`.

```
svlentink@penguin:~$ man sed|head -8
SED(1)                          User Commands                         SED(1)

NAME
       sed - stream editor for filtering and transforming text

SYNOPSIS
       sed [OPTION]... {script-only-if-no-other-script} [input-file]...

svlentink@penguin:~$ whatis sed
sed (1)              - stream editor for filtering and transforming text
svlentink@penguin:~$ whatis cat
cat (1)              - concatenate files and print on the standard output
svlentink@penguin:~$ whatis curl
curl (1)             - transfer a URL
```

## File conversion

We will now create our own code.

Image we have an excel sheet (data in a table),
but we want to use Git as version control
or simply want the table to be closer to the code.
We can save the `.xlsx` in Git,
but this wouldn't be very practical.
It's better to have it as Markdown inside in Git
so one can see the table contents in the Git webui.

Thus we want to convert the excel/sheet data into markdown table format.
We first observe that we can dump a sheet in excel/google sheets as an `.csv`,
which gives us:

```csv
john,male,21
alice,female,23
```

We observe that
[Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
uses the following format:

```markdown
| A | B | C |
| --- | --- | --- |
| john | male | 21 |
| alice | female | 23 |
```

So we want to create this format using a script.
We first see that Markdown needs a table head.
So our script will look like the following:

```sh
echo '| A | B | C |'
echo '| --- | --- | --- |'
```

Now we need to add the lines from the `.csv` file
and convert it to the table format.
We first fiddle around and find how to convert a row:

```sh
echo 'john,male,21'|sed 's/^/|\ /g'|sed 's/,/\ |\ /g'|sed 's/$/\ |/g'
# OR
echo 'john,male,21' \
  | sed 's/^/|\ /g' \
  | sed 's/,/\ |\ /g' \
  | sed 's/$/\ |/g'
```

Where the first `sed` adds a '| ' to the start of a row,
the middle transforms all ',' to ' | ' and the last appends ' |'.

We now creat a script adding a
[shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))
and a wrapper around it so you can paste it in your terminal:

```sh
cat << 'EOF' > /tmp/script.sh
#!/bin/sh
echo '| A | B | C |'
echo '| --- | --- | --- |'
cat $1 \
  | sed 's/^/|\ /g' \
  | sed 's/,/\ |\ /g' \
  | sed 's/$/\ |/g'
EOF
```

We can now test this script:

```sh
cat << EOF | sh /tmp/script.sh
john,male,21
alice,female,23
EOF
```

Which works very well!

We will now create a slightly updated script:

```bash
mkdir -p /usr/local/bin

cat << 'EOF' > /usr/local/bin/csv2md
#!/bin/bash -e

# check if the second argument given to the script is set
if [ -z "$2" ]; then
  echo "USAGE: $0 COLUMNCOUNT exceldump.csv > mytable.md"
  exit 1
fi

HEADER1='|'
HEADER2='|'
for i in $(seq 1 $1); do
  HEADER1="$HEADER1 $i |"
  HEADER2="$HEADER2 --- |"
done

echo $HEADER1
echo $HEADER2
cat $2 \
  | sed 's/^/|\ /g' \
  | sed 's/,/\ |\ /g' \
  | sed 's/$/\ |/g'

exit 0
EOF

chmod +x /usr/local/bin/csv2md
```

Which we can now test:

```sh
cat << EOF > /tmp/test.csv
john,male,21
alice,female,23
EOF

csv2md 3 /tmp/test.csv
```

Which gives the output:

```md
| 1 | 2 | 3 |
| --- | --- | --- |
| john | male | 21 |
| alice | female | 23 |
```

Or in markdown (in which I write this blog):

| 1 | 2 | 3 |
| --- | --- | --- |
| john | male | 21 |
| alice | female | 23 |


Hoped you learned something today,
keep searching for potential situations for creating a script
and learn along the way.

