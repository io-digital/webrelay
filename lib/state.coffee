
{get} = require('http')

module.exports = (ip, callback) ->

  get("http://#{ip}/stateFull.xml", (res) ->
    received = ''
    res.on('data', (data) -> received += data.toString())
    res.on('end', ->
      process.nextTick( -> callback(null, received))
    )
  ).on('error', (err) ->
    process.nextTick( -> callback(err, null))
  )
