# conversation-nores view

app.directive 'conversationNores', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-nores'] is true
      $load.views['conversation-nores'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-nores/conversation-nores.css'
    restrict: 'C'
    templateUrl: 'views/conversation-nores/conversation-nores.html'
    link: (scope, $el) ->
      conversationNores = $el[0]

]
