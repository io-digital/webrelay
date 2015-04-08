
# response
# <?xml version='1.0' encoding='utf-8' ?>
# <datavalues>
#   <relay1state>0</relay1state>
#   <relay2state>0</relay2state>
#   <relay3state>0</relay3state>
#   <relay4state>0</relay4state>
# </datavalues>

# power states
# 0 = OFF (dc power on)
# 1 = ON (dc power off)
# 2 = PULSE

{get} = require('http')

module.exports = (ip, breaker, value, callback) ->

  get("http://#{ip}/stateFull.xml?relay#{breaker}State=#{value}&time=", (res) ->
    received = ''
    res.on('data', (data) -> received += data.toString())
    res.on('end', ->
      process.nextTick( -> callback(null, received))
    )
  ).on('error', (err) ->
    process.nextTick( -> callback(err, null))
  )
