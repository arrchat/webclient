# conversation-item view

app.directive 'conversationItem', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-item'] == !0
      $load.views['conversation-item'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-item/conversation-item.css'
    restrict: 'C'
    templateUrl: 'views/conversation-item/conversation-item.html'
    link: (scope, $el) ->
      conversationItem = $el[0]

]
