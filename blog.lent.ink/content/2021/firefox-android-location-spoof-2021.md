---
title: "Firefox Add-on location faking on Android 2021"
date: "2021-01-01"
draft: true
tags: ["category01"]
---


Since Firefox for Android has been update,
most Add-ons (browser extensions) are disabled.
In this post I show how to side load an add-on in 2021.

## Step01 enable loading custom add-ons

Follow
[this](https://blog.mozilla.org/addons/2020/09/29/expanded-extension-support-in-firefox-for-android-nightly/)
guide.

## Step02

Write an extension that
[overwrites](https://github.com/shacharmo/ChromeGeolocationSpoof/blob/master/extension/chrome/src/contentPage.ts)
the `navigator.geolocation` API.
Or use the code below:

```javascript
const chrome = chrome || browser

function get_coords(callback){
	//https://www.google.com/maps/@33.53296,-52.3360011,6.95z
	let queryOptions = { url : "https://www.google.com/maps*" }
	// https://developer.chrome.com/docs/extensions/reference/tabs/
	chrome.tabs.query(queryOptions, tabs => {
		let tab = tabs[0]
		let splitURL = tab.url.split('/maps/@')
		if (splitURL.length !== 2) return {
			long: 0.123,
			lat: 0.123,
		}
		let splitCoords = splitURL[1].split(',')
		callback({
			long: splitCoords[1],
			lat: splitCoords[0],
		})
	})
}

let overwrite = (successCallback) => {
	get_coords( retrieved => {
		successCallback({
			coords: {
				latitude: retrieved.lat,
				longitude: retrieved.long,
				accuracy: 123.45,
				heading: null,
				speed: null,
				altitude: null,
				altitudeAccuracy: null,
			},
			timestamp: null //Date.now(),
		})
	})
}
navigator.geolocation.getCurrentPosition = overwrite
navigator.geolocation.watchPosition = overwrite
```

[manifest.json](https://github.com/GoogleChrome/chrome-extensions-samples/blob/main/examples/page-redder/manifest.json)
```json

{
  "manifest_version": 2,
  "name": "location spoofing",
  "version": "0.0.1",
  "description": "Spoof your geolocation. You have one tab open on google.com/maps zoomed in on a location, then the lat/long of that URL is used on all other tabs their geolocation.",
  "permissions": [ "tabs", "geolocation" ],
  "host_permissions": [
    "https://*"
  ],
  "background" : { "scripts": ["background.js"] }
}
```


Tags:
Location Guard,
FIXME


Learned a lot;
`tabs.query` is only available in a background script,
while you need `content_scripts` or `tabs.executeScript` to inject code in the page,
in order to overwrite the `window` in the
[page its context](https://stackoverflow.com/questions/12395722/can-the-window-object-be-modified-from-a-chrome-extension).
And `manifest_version` 3 is promoted by Chrome but unavailable in Firefox.

