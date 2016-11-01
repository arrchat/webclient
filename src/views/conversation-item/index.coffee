# conversation-item view

app.directive 'conversationItem', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-item'] is true
      $load.views['conversation-item'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-item/conversation-item.css'
    restrict: 'C'
    templateUrl: 'views/conversation-item/conversation-item.html'
    link: (scope, $el) ->
      conversationItem = $el[0]

]
