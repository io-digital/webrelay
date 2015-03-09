
{spawn} = require('child_process')

arp = (ip, mac, fn) ->

  stdout = stderr = ''

  # default ip '192.168.88.30'
  # default mac '00:0c:c8:03:13:22'

  arp = spawn('arp', ['-s', ip, mac])

  arp.stdout.on('data', (data) -> stdout += data.toString())
  arp.stderr.on('data', (data) -> stderr += data.toString())

  arp.on('close', (code) ->
    if code isnt 0
      fn(code, null)
    else
      fn(null, true)
  )

ping = (ip, fn) ->

  stdout = stderr = ''

  ping = spawn('ping', ['-c', '1', '-s', '102', '-o', ip])

  ping.stdout.on('data', (data) -> stdout += data.toString())
  ping.stderr.on('data', (data) -> stderr += data.toString())

  ping.on('close', (code) ->
    if code is 0
      fn(null, {transmitted: true, responded: true})
    else if code is 2
      fn(null, {transmitted: true, responded: false})
    else
      fn(code, null)
  )

module.exports = (relayIP, relayMAC, callback) ->

  arp(relayIP, relayMAC, (arpError, res) ->
    if arpError
      callback(arpError, null)
    else
      ping(relayIP, (pingError, res) ->
        if pingError
          callback(pingError, null)
        else
          callback(null, true)
      )
  )
