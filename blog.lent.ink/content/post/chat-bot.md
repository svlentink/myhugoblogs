---
title: "An introduction to coding: chat bot for MS teams"
date: "2019-11-27"
draft: false
tags: ["coding"]
---

This guide creates a script that monitors the current open chat
and responds with a message if a new message has been received.

In our previous
[introduction to coding](https://blog.lent.ink/post/start-coding/)
we looked at a structural approach
to gradually become a programmer.
But that guide required `bash`,
which takes some initial setup on Windows (using WSL).
This post only requires the Chrome browser
and access to [teams.microsoft.com](https://teams.microsoft.com).

## Step 00 preparation

- Open a chat to a colleague
- Hit `ctrl` + `shift` + `j` to open the console

![chrome console](/img/chrome-console.png "chrome console")

Now that we have the console,
we restrict the output by selecting to only see the 'Verbose' output.

## Step 01 textbox

We find the textbox that holds 'Type a new message' and right click on it,
select 'Inspect'.
This is how one can find the element in a web page.

We see that the Developer view has switched to the Elements tab,
switch it back to the Console.

Paste the following in the console

```javascript
document.querySelector('#cke_1_contents').children[0]
```
and hit enter.
We now get an output that starts with `<div`,
this is the textbox element.

## Step 02 text in textbox

We will show the code,
where everything behind `//` is a comment.
These comments are only for humans,
the computer ignores them.

```javascript
// We create a function that set the text in the textbox
// this function accepts some input
function setText(input) {
  // we first make a variable of this textbox element on the page
  var textbox = document.querySelector('#cke_1_contents').children[0]
  // then we tell the textbox that its innerText is our input
  textbox.innerText = input
}
// We now created our first Javascript function!
```

Programmers prefer to have readable code over extensible documentation.
This can be done by meaningful variable names and comments.

Put the function (with or without comments) in the console.
Now put the following line in the console to test the function we created:
```javascript
setText("This text should appear in the textbox")
```

## Step 03 sending text

Study the following code and paste it into the console.

```javascript
// this function has no input arguments
// when called, it finds the button
// and simulates a click for it
function hitSend() {
  var button = document.querySelector('#send-message-button')
  button.click()
}

// this function uses the previous two functions
function sendMsg(input) {
  setText(input)
  hitSend()
}
```

One can now test this code:
```javascript
sendMsg("Sending this test message from the console in my browser")
```

Be curious and play around, you can get parts of a function
and see what it does:
```javascript
document.querySelector('#send-message-button')
```

## Step 04 creating bot

The following code creates an auto reply bot.

```javascript
function checkNewMsg() {
  // we first get the element holding all the messages
  var messageslist = document.querySelector('.ts-message-list-container')
  // the items in this element are its children
  var messages = messageslist.children
  // then we get the amount of messages currently displayed in this chat screen
  var msgcount = messages.length
  
  // if no (!) record is kept of the lastknowncount
  // the lastknowncount is set to the current count
  if (! window.lastknowncount)
    window.lastknowncount = msgcount

  // if the current message count is larger than the
  // lastknowncount, we received a message
  if (msgcount > window.lastknowncount){
    sendMsg("Check! I'm working on it boss!")
    // to prevent our message from being the new message that triggers
    // sending yet another new message, we clear the counter again
    window.lastknowncount = undefined
  }
}

// every 2000ms (2s) we run the checkNewMsg function
window.setInterval(checkNewMsg,2000)
```

