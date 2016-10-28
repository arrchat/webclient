# conversation-search view

app.directive 'conversationSearch', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-search'] == !0
      $load.views['conversation-search'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-search/conversation-search.css'
    restrict: 'C'
    templateUrl: 'views/conversation-search/conversation-search.html'
    link: (scope, $el) ->
      conversationSearch = $el[0]

]
