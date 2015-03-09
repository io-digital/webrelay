
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
      fn(code, {code: code, out: stdout, err: stderr})
    else
      fn(null, {code: code, out: stdout, err: stderr})
  )

ping = (ip, fn) ->

  stdout = stderr = ''

  ping = spawn('ping', ['-c', '1', '-s', '102', '-o', ip])

  ping.stdout.on('data', (data) -> stdout += data.toString())
  ping.stderr.on('data', (data) -> stderr += data.toString())

  ping.on('close', (code) ->
    if code is 0
      fn(null, {code: code, raw: stdout, transmitted: true, responded: true})
    else if code is 2
      fn(null, {code: code, out: stdout, err: stderr, transmitted: true, responded: false})
    else
      fn(code, {code: code, out: stdout, err: stderr, transmitted: false, responded: false})
  )

module.exports = (relayIP, relayMAC, callback) ->

  errors = arp: null, ping: null

  arp(relayIP, relayMAC, (arpErr, arpRes) ->

    if arpErr
      errors.arp = arpRes
      return callback(errors, null)

    ping(relayIP, (pingErr, pingRes) ->

      if pingErr
        errors.ping = pingRes
        callback(errors, null)
      else if pingRes.responded
        callback(null, true)
      else
        errors.ping = pingRes
        callback(errors, null)
    )

  )
