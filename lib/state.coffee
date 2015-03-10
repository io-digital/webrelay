
{get} = require('http')

module.exports = (ip, callback) ->

  get("http://#{ip}/stateFull.xml", (res) ->
    received = ''
    res.on('data', (data) -> received += data.toString())
    res.on('end', -> callback(null, received))
  ).on('error', (err) ->
    callback(err, null)
  )
