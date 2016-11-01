Socket = require './socket'
Packet = require './packet'

# proto service
app.factory 'proto', [
  '$rootScope'
  '$location'
  ($scope, $location) ->
    proto = {}
    # proto service logic

    proto.socket = new Socket 'webchat.juniorjpdj.pl:444', $location
    proto.packet = Packet proto.socket

    proto

]
