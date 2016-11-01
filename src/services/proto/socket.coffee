class Socket
  constructor: (host, $location) ->
    return Socket.sockets[0] if Socket.sockets.length > 1
    Socket.sockets.push @
    protocol = $location.protocol().replace /(file|http)/, 'wss'
    ws = protocol + '://' + host + '/ws'
    @socket = new ReconnectingWebSocket ws
    waff.EventEmitter.extend @
    @socket.binaryType = 'arraybuffer'
    @connected = false
    @socket.addEventListener 'open', =>
      @connected = true
      @emit 'connect'
    @socket.addEventListener 'close', =>
      @connected = false
      @emit 'disconnect'
    @socket.addEventListener 'message', (e) =>
      @decode e
        .then (data) =>
          @emit 'message', data
          if data.packet_type?
            @emit 'packet::' + data.packet_type, data

  decode: (e) ->
    new waff.Promise (resolve, reject) ->
      fileReader = new FileReader
      fileReader.onload = ->
        resolve msgpack.decode new Uint8Array @result
      fileReader.readAsArrayBuffer e.data

  send: (data) ->
    @socket.send msgpack.encode data
    @

Socket.sockets = []
Socket.getSocket = ->
  Socket.sockets[0]

module.exports = Socket
