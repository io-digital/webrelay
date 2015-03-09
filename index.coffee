funcs = require('./lib')

funcs.setup(funcs.config.RELAY_HOST, funcs.config.RELAY_MAC, (err, res) ->
  throw err if err
  console.log(res)
)
