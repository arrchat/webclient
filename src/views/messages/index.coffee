# messages view

app.directive 'messages', [
  '$rootScope'
  ($scope) ->
    unless $load.views['messages'] == !0
      $load.views['messages'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/messages/messages.css'
    restrict: 'C'
    templateUrl: 'views/messages/messages.html'
    link: (scope, $el) ->
      messages = $el[0]

]
