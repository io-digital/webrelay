
# webrelay

[![NPM](https://nodei.co/npm/webrelay.png?compact=true)](https://nodei.co/npm/webrelay/)

[![Build Status](https://travis-ci.org/io-digital/webrelay.svg)](https://travis-ci.org/io-digital/webrelay)
[![devDependency Status](https://david-dm.org/io-digital/webrelay/dev-status.svg)](https://david-dm.org/io-digital/webrelay#info=devDependencies)

[![Coverage Status](https://coveralls.io/repos/io-digital/webrelay/badge.svg?branch=master)](https://coveralls.io/r/io-digital/webrelay?branch=master)
[![Dependency Status](https://david-dm.org/io-digital/webrelay.svg)](https://david-dm.org/io-digital/webrelay)

http wrapper for operating a controlbyweb relay device

##### usage

the module is programmed to spy at environment variables and runtime arguments for configuration data. runtime arguments take precedence over environment variables and default values.

below is an example of adding an `arp` entry and verifying that the device replies via a `ping` test.

```js
var webrelay = require('webrelay');
var config = webrelay.config;

webrelay.setup(config.RELAY_HOST, config.RELAY_MAC, (err, res) ->
  if (err) throw err;
  console.log(res);
);
```
