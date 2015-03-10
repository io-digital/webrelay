
{expect} = require('chai')
sinon = require('sinon')

relay = require('../lib')

describe 'webrelay', ->

  @timeout(60000)

  it 'should export config, setup, state and switch', ->

    expect(relay).to.contain.keys(['config', 'setup', 'state', 'switch'])

  describe 'setup', ->

    describe '#ping', ->

      it 'should exit cleanly for a real host (code 0)', (done) ->

        relay.setup.ping('127.0.0.1', (err, res) ->
          expect(err).to.equal(null)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).to.equal(0)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(true)
          done()
        )

      it 'should freak out if gibberish is given as a host address (code > 2)', (done) ->

        relay.setup.ping('kasdfjs', (err, res) ->
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).gt(2)
          expect(res.transmitted).to.equal(false)
          expect(res.responded).to.equal(false)
          done()
        )

      it 'should exit with code 2 if host is unreachable', (done) ->

        relay.setup.ping('127.0.0.2', (err, res) ->
          expect(err).to.equal(null)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).to.equal(2)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(false)
          done()
        )


