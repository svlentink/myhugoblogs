---
title: "Chrome extension to block incoming video"
date: "2021-02-05"
draft: true
---


Now that we're doing video calls all day,
I encountered some issues with Webex.
In MS teams I have the option to disable other's webcam,
which saves laptop performance and bandwidth,
in Slack and Webex I do not have this option.
Hence this post, to create a chrome extension doing just that.

```
document.setInterval(() => {
  for (var v of document.querySelectorAll('video'))
    v.pause()
},300)
let v=document.querySelector('video');v.parentElement.removeChild(v)
```

the screen sharing is a canvas element
but webapp does not allow you to disable video, thus this extension


#### Motivation

Since I mostly used Webex, I only share my issues with that one.
Not sure if this is Webex their fault or that the company managing the laptop
are causing some of the issues, regardless, the product is buggy or allows it to be configured buggy.

- Camera blurs background, settings says it is not enabled (product issue)
- Could change displayed name in desktop app, later only when using browser (company policy)
- When joining a call on desktop app, volume jumps to 2% (product issue)
- When opening desktop app, sometimes it has a different UI language
- Someone dropped out of participants list, but was still able to hear us speaking (product issue)
- Button says "unmute" but person isn't actually muted (product issue)
- Sometimes user pictures are shown (when webcam disabled) sometimes not (product issue)


