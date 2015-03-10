
# webrelay

[![NPM](https://nodei.co/npm/webrelay.png?compact=true)](https://nodei.co/npm/webrelay/)

[![Build Status](https://travis-ci.org/io-digital/webrelay.svg)](https://travis-ci.org/io-digital/webrelay)
[![devDependency Status](https://david-dm.org/io-digital/webrelay/dev-status.svg)](https://david-dm.org/io-digital/webrelay#info=devDependencies)

[![Coverage Status](https://coveralls.io/repos/io-digital/webrelay/badge.svg?branch=master)](https://coveralls.io/r/io-digital/webrelay?branch=master)
[![Dependency Status](https://david-dm.org/io-digital/webrelay.svg)](https://david-dm.org/io-digital/webrelay)

http wrapper for operating a [ControlByWeb](http://www.controlbyweb.com/) relay device

##### api

- `#setup(host, mac, callback)` add an `arp` entry and test with `ping`
- `#switch(host, breaker, state, callback)` change the state of `breaker` to `state` and return the state of the relay (xml)
- `#state(host, callback)` return the state of the relay (xml)

##### usage

the module is programmed to spy at environment variables and runtime arguments for configuration data. runtime arguments take precedence over environment variables and default values.

```js
var webrelay = require('webrelay'),
    host = webrelay.config.RELAY_HOST,
    mac = webrelay.config.RELAY_MAC;

// initial set up
webrelay.setup(host, mac, function(err, res) {
  if (err) throw err;
  // relay is now accessible via config.RELAY_HOST
});

// toggle a breaker
webrelay.switch(host, 1, 1, function(err, res) {
  if (err) throw err;
  // breaker number 1's state is now 1
});

// get the state back (in xml)
webrelay.state(host, function(err, res) {
  if (err) throw err;
  console.log(res);
});
```
