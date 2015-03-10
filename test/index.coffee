
{expect} = require('chai')
sinon = require('sinon')

relay = require('../lib')

describe 'webrelay', ->

  @timeout(60000)

  describe 'module', ->

    it 'should export config, setup, state and switch', ->

      expect(relay).to.contain.keys(['config', 'setup', 'state', 'switch'])

  describe '#setup', ->

    describe '#ping', ->

      it 'should respond with an object containing specific keys', (done) ->

        relay.setup.ping('127.0.0.1', (err, res) ->
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          done()
        )

      it 'should exit cleanly for a real host (code 0)', (done) ->

        relay.setup.ping('127.0.0.1', (err, res) ->
          expect(err).to.equal(null)
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).to.equal(0)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(true)
          done()
        )

      it 'should exit with code 2 or greater if host is unreachable', (done) ->

        relay.setup.ping('lkjsflkjs', (err, res) ->
          expect(res).to.contain.keys(['code', 'out', 'err', 'transmitted', 'responded'])
          expect(res.code).gte(2)
          expect(res.transmitted).to.equal(true)
          expect(res.responded).to.equal(false)
          done()
        )

    describe '#arp', ->

      it 'should respond with an object containing specific keys', (done) ->

        relay.setup.arp('lajsfdls', 'lkajsdfljs', (err, res) ->
          expect(res).to.contain.keys(['code', 'out', 'err'])
          done()
        )

      it 'should not exit cleanly if it is given gibberish', (done) ->

        relay.setup.arp('lajsfdls', 'lkajsdfljs', (err, res) ->
          expect(err).gt(0)
          done()
        )
