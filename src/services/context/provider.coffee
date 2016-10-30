module.exports = (provider) ->
  data:
    name: provider.name
    desc: 'Provider id: {0}'.format provider.id
  menu:
    remove:
      action: ->
        console.log 'removing {0}'.format provider.name
