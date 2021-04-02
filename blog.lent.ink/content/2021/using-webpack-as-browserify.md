---
title: "Using Webpack as browserify"
date: "2021-04-01"
draft: false
tags: ["coding"]
---

My initial setup was bundling everything together into one javascript bundle,
however,
I wanted to lower the building time and get faster feedback loops.
For this I am using
[shimming](https://webpack.js.org/guides/shimming/)
and EcmaScript 6 modules.

## Shimming npm packages using webpack

The default way (by webpack) of accessing modules (global variable),
wasn't my cup of tea,
the current approach is inspired by
[this](https://stackoverflow.com/questions/49562978/how-to-use-npm-modules-in-browser-is-possible-to-use-them-even-in-local-pc).

We first create the shim:
```javascript
import * as mod from 'yamljs'
if (! window.npm) window.npm = {}
window.npm['yamljs'] = mod
```
which we then convert using webpack (see the details in the codeblock below)
and allows us to import it like:
```javascript
import * as hack from './yamljs.js'
const YAML = window.npm['yamljs'].default
```

## Webpack 5

When tackling this problem, I didn't have my packages pinned to a version,
thus I also went through an
[upgrade](https://github.com/isaacs/core-util-is/issues/27)
of Webpack, from 4 to 5.
This removed the
[polyfills](https://github.com/webpack/changelog-v5/blob/master/README.md#automatic-nodejs-polyfills-removed),
resulting in an error when running `ical_obj.toString()`:
```
Uncaught ReferenceError: Buffer is not defined
```

For this issue, the
[suggested methods](https://stackoverflow.com/questions/65894521/webpack-5-node-polyfill-instructions-dont-work)
of using `resolve.fallback` (which was `node` in v4) or
[`resolve.alias`](https://sanchit3b.medium.com/how-to-polyfill-node-core-modules-in-webpack-5-905c1f5504a0)
did not work.

What did work was:
```javascript
// webpack.config.json
const path = require('path');
module.exports = [{
  mode: "production",
  entry: [
    './ical-generator.mjs'
  ],
  output: {
    filename: './ical-generator.js',
    path: __dirname,
  },
  resolve: {
    fallback: {
      fs: false,
//      buffer: require.resolve("buffer/"),
    },
/*
    alias: {
      buffer: "buffer",
    },
*/
}]


// package.json
{
  "name": "bundler",
  "version": "0.0.1",
  "scripts": {
    "build": "webpack"
  },
  "dependencies": {
    "webpack": "*", "webpack-cli": "*",
    "ical-generator": "*", "fs":"*", "buffer": "*",
  }
}


// ical-generator.mjs
import { Buffer } from 'buffer/'
window.Buffer = Buffer
import * as mod from 'ical-generator'
if (! window.npm) window.npm = {}
window.npm['ical-generator'] = mod
```

After running `npm install; npm run build` we can now use the library in our code:
```
import * as hack from "./ical-generator.js'
const ical = window.npm['ical-generator'].default
```

