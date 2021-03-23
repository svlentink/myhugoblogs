---
title: "Export csv from Google sheets"
date: "2021-03-23"
draft: false
tags: ["coding"]
---

For a PoC, I wanted to use Google sheets as a data store
for rendering charts.
Trying to share a sheet via 'Publish to the web' as a csv did not work,
since it'll redirect you to an HTML page first,
which makes it unusuable for automated systems.
Searching for a solution lead to someone who
[shared](https://natechamberlain.com/2019/10/08/connect-a-google-sheet-spreadsheet-to-power-bi-as-a-data-source/)
how to get the xlsx exported,
which helped me find out how to get it as csv.

```js
let shared_to_anyone_with_the_link = "https://docs.google.com/spreadsheets/d/REDACTED/edit?usp=sharing"

function sharing_url_to_csv_url(sharing_url, sheet_index=0){
	let url_start = sharing_url.split('/edit?')[0]
	const url_postfix = '/export?format=csv&single=true'
	let url_spreadsheetid = '&id=' + url_start.split('/').pop()
	let url_sheetid = '&gid=' + sheet_index

	let csv_url = url_start + url_postfix + url_spreadsheetid + url_sheetid
	return csv_url
}

sharing_url_to_csv_url(shared_to_anyone_with_the_link)
```

The sheet index can be found when one uses 'Publish to the web' and select a single sheet.

With the result of the function, we can now get our data using:
```
curl -L https://docs.google.com/spreadsheets/....
```

