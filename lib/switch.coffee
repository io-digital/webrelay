
# devices
# Relay 3 = router / node / wireless hotspot
# Relay 2 = wireless hotspot
# Relay 1 = BGAN
#
# response
# ```xml
# <?xml version='1.0' encoding='utf-8' ?>
# <datavalues>
#   <relay1state>0</relay1state>
#   <relay2state>0</relay2state>
#   <relay3state>0</relay3state>
#   <relay4state>0</relay4state>
# </datavalues>
# ```

# power states
# ```
# 0 = OFF (dc power on)
# 1 = ON (dc power off)
# 2 = PULSE
# ```

{get} = require('http')

module.exports = (ip, breaker, value, callback) ->

  get("http://#{ip}/stateFull.xml?relay#{breaker}State=#{value}&time=", (res) ->
    # console.log("Got response: " + res.statusCode)
    callback(null, 200)
  ).on('error', (err) ->
    # console.log("Got error: " + err.message)
    callback(err, 500)
  )
