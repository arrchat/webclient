# conversations view

app.directive 'conversations', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversations'] is true
      $load.views['conversations'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversations/conversations.css'
    restrict: 'C'
    templateUrl: 'views/conversations/conversations.html'
    link: (scope, $el) ->
      conversations = $el[0]

]
