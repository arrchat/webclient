# conversation-options view

app.directive 'conversationOptions', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-options'] == !0
      $load.views['conversation-options'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-options/conversation-options.css'
    restrict: 'C'
    templateUrl: 'views/conversation-options/conversation-options.html'
    link: (scope, $el) ->
      conversationOptions = $el[0]

]
