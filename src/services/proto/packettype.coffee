module.exports = do ->

  # NOTE:
  # Two options are valid:
  #
  # $proto.packet.type.client.getProviders
  # $proto.packet.type.client.get.providers

  client = [
    'confirmation', 'response', 'getProviders', 'login',
    'logout', 'getContacts', 'getHistory', 'sendMessage'
    'editMessage', 'deleteMessage', 'readMessage', 'setStatus'
    # not implemented

  ]
  server = [
    'confirmation', 'session', 'info', 'newContact'
    'newMessage', 'deletedMessage', 'editedMessage', 'readMessage',
    'statusChanged', 'memberlistChanged'
    # not implemented
  ]

  prepare = (types) ->
    res = {}
    for type, i in types
      path = type.replace /([a-z])([A-Z])/, '$1 $2'
      path = path.split ' '
      path = (n = n.toLowerCase() for n in path)
      _.set res, path, i
      res[type] = i
    res

  client: prepare client
  server: prepare server
