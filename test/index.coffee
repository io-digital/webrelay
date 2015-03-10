
{expect} = require('chai')
sinon = require('sinon')

relay = require('../lib')



describe 'webrelay', ->

  @timeout(10000)

  it 'should export config, setup, state and switch', ->

    expect(relay).to.contain.keys(['config', 'setup', 'state', 'switch'])

  describe 'config', ->

    it 'should make env vars take precedence over default values', ->

      expect(relay.config.RELAY_HOST).to.equal('testing')
      expect(relay.config.RELAY_MAC).to.equal('testing')

  describe 'setup', ->

    describe '#ping', ->

      it 'should transmit to loopback and get a response (code 0)', (done) ->

        relay.setup.ping('localhost', (err, res) ->
          expect(err).to.equal(null)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).to.equal(0)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(true)
          done()
        )

      it 'should freak out if gibberish is given as a host address (code > 2)', (done) ->

        relay.setup.ping('lajsdfl', (err, res) ->
          expect(err).gt(2)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).gt(2)
          expect(res.transmitted).to.equal(false)
          expect(res.responded).to.equal(false)
          done()
        )

      it 'should transmit to the given host and respond with code 2 if it is unreachable', (done) ->

        relay.setup.ping('192.168.0.255', (err, res) ->
          expect(err).to.equal(null)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).to.equal(2)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(false)
          done()
        )


