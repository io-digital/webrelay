funcs = require('./lib')

funcs.setup(funcs.config.RELAY_HOST, funcs.config.RELAY_MAC, (err, res) ->
  if err.arp or err.ping
    console.log(err)
)
