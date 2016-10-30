module.exports = (provider) ->
  data:
    name: provider.name
    desc: 'Provider id: {0}'.format provider.id
  menu:
    'option 1':
      action: ->
        console.log 'removing {0}'.format provider.name
    'option 2':
      action: ->
        console.log 'removing {0}'.format provider.name
    remove:
      action: ->
        console.log 'removing {0}'.format provider.name
