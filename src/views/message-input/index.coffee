# message-input view

app.directive 'messageInput', [
  '$rootScope'
  ($scope) ->
    unless $load.views['message-input'] == !0
      $load.views['message-input'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/message-input/message-input.css'
    restrict: 'C'
    templateUrl: 'views/message-input/message-input.html'
    link: (scope, $el) ->
      messageInput = $el[0]

]
