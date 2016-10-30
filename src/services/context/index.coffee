# context service

contexts = {}
<% contexts.forEach(function(context){ %>
contexts['<%= context %>'] = require './<%= context %>'
<% }) %>

app.factory 'context', [
  '$rootScope'
  ($scope) ->
    context = {}
    # context service logic
    context.open = (entry, scope) ->
      handler = contexts[entry]
      throw new Error 'Context \'{0}\' not found'.format entry unless handler?
      $event.focus = q '.context'
      $scope.context = handler scope


    context
]
