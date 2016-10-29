# conversation-search view

app.directive 'conversationSearch', [
  '$rootScope'
  '$timeout'
  ($scope, $timeout) ->
    unless $load.views['conversation-search'] == !0
      $load.views['conversation-search'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-search/conversation-search.css'
    restrict: 'C'
    templateUrl: 'views/conversation-search/conversation-search.html'
    link: (scope, $el) ->
      conversationSearch = $el[0]
      button = conversationSearch.q 'img'
      input = conversationSearch.q 'input'
      button.on 'click', (e) ->
        e.preventDefault()
        $timeout ->
          conversationSearch.class.add 'focus'
          $event.focus = conversationSearch
          input.focus()

]
