class Storage
  constructor: (@id, @name) ->
    @profiles = {}
    Object.defineProperty @, 'data',
      configurable: true
      get: =>
        res = {}
        for k, v of @
          res[k] = v if !~[ 'save', 'load' ].indexOf k
        res
      set: (data) =>
        for k, v of @
          @[k] = v if !~[ 'save', 'load' ].indexOf k

  # Function to load @data from storage
  load: ->

  # Function to save @data to storage
  save: ->
module.exports = Storage
