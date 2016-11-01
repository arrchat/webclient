# messages view

app.directive 'messages', [
  '$rootScope'
  ($scope) ->
    unless $load.views['messages'] is true
      $load.views['messages'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/messages/messages.css'
    restrict: 'C'
    templateUrl: 'views/messages/messages.html'
    link: (scope, $el) ->
      messages = $el[0]

]
