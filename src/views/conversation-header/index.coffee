# conversation-header view

app.directive 'conversationHeader', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-header'] is true
      $load.views['conversation-header'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-header/conversation-header.css'
    restrict: 'C'
    # templateUrl: 'views/conversation-header/conversation-header.html'
    link: (scope, $el) ->
      conversationHeader = $el[0]

]
