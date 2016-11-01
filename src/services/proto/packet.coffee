Type = require './packettype'
module.exports = (socket) ->
  class Packet
    constructor: (@type, @data, @autoresend = true) ->
      @id = ++Packet.count
      @data ?= {}
      @sent = false
      @delivered = false

    send: ->
      @sent = true
      pack =
        packet_type: @type
        query_id: @id
      for key, value of @data
        pack[key] = value unless key is 'packet_type' or key is 'query_id'
      console.log '[client]', pack
      socket.send pack

      @timer = =>
        unless @delivered is true
          socket.send pack
          console.log  @delivered, 'sending packet again'
          setTimeout @timer, 10000

      if @autoresend is true
        setTimeout @timer, 10000

      new waff.Promise (resolve, reject) =>
        handler = (res) =>
          
          console.log '[server]', res if $debug
          return @delivered = true if res.query_id is @id and res.packet_type is Type.server.confirmation

          if res.response_id is @id
            socket.off 'message', handler
            resolve res

        socket.on 'message', handler

  Packet.count = -1
  Packet.type = Type
  Packet
