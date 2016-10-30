String::format = ->
  args = arguments
  @replace /\{\d+\}/g, (a) ->
    a = args[a.slice(1, -1)]
    if a? then a else ''
