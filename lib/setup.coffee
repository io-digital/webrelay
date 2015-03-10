
{spawn} = require('child_process')

exports.arp = (ip, mac, fn) ->

  stdout = stderr = ''

  arp = spawn('arp', ['-s', ip, mac])

  arp.stdout.on('data', (data) -> stdout += data.toString())
  arp.stderr.on('data', (data) -> stderr += data.toString())

  arp.on('close', (code) ->
    if code isnt 0
      fn(code, {code: code, out: stdout, err: stderr})
    else
      fn(null, {code: code, out: stdout, err: stderr})
  )

exports.ping = (ip, fn) ->

  stdout = stderr = ''

  ping = spawn('ping', ['-c', '2', '-s', '102', ip])

  ping.stdout.on('data', (data) -> stdout += data.toString())
  ping.stderr.on('data', (data) -> stderr += data.toString())

  ping.on('close', (code) ->

    if code is 0
      fn(null, {code: code, out: stdout, err: stderr, transmitted: true, responded: true})
    else if code is 2 or code is 68
      fn(null, {code: code, out: stdout, err: stderr, transmitted: true, responded: false})
    else
      fn(code, {code: code, out: stdout, err: stderr, transmitted: false, responded: false})
  )

exports.run = (relayIP, relayMAC, callback) ->

  errors = arp: null, ping: null

  @arp(relayIP, relayMAC, (arpErr, arpRes) =>

    if arpErr
      errors.arp = arpRes
      return callback(errors, null)

    @ping(relayIP, (pingErr, pingRes) ->

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
