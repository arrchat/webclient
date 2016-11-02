class Profile
  constructor: ($storage, $crypt, serialized) ->

    if typeof serialized is 'string' and $storage.profiles[serialized]?
      @name = serialized
      for field in [ 'providers', 'desc', 'pass', 'crypt', 'storage' ]
        @[field] = $storage.profiles[@name][field]
    else if typeof serialized is 'object'
      for field in [ 'name', 'providers', 'desc', 'pass', 'crypt', 'storage' ]
        @[field] = serialized[field]
        @save()
    else
      @name = 'new profile'
      @providers = []
      @desc = 'profile description'
      @pass = ''
      @storage = 0
      @crypt = 0
      @save()
  save: ->
    $storage.profiles[@name] = @serialize()

  login: (pass) ->
    @__ = new $crypt[@crypt].instance pass
    res = @__.pass is @pass
    @__.pass = null
    res

  serialize: ->
    desc: @desc
    pass: @pass
    crypt: @crypt

    providers: @__.encrypt @providers

module.exports = Profile
