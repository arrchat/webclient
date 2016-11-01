# context service

contexts = {}
<% contexts.forEach(function(context){ %>
contexts['<%= context %>'] = require './<%= context %>'
<% }) %>

app.factory 'context', [
  '$rootScope'
  '$timeout'
  ($scope, $timeout) ->
    context = {}
    # context service logic
    context.open = (entry, scope, event) ->
      handler = contexts[entry]
      throw new Error 'Context \'{0}\' not found'.format entry unless handler?
      $event.focus = q '.context'
      $timeout ->
        $scope.context = handler scope

        $timeout ->
          w = $event.focus.offsetWidth
          h = $event.focus.offsetHeight

          console.log event.clientY, h, window.innerHeight

          $event.focus.css
            top:  if event.clientY + h > window.innerHeight then event.clientY - h else event.clientY
            left: if event.clientX + w > window.innerWidth  then event.clientX - w else event.clientX


    context
]
