# conversation-options view

app.directive 'conversationOptions', [
  '$rootScope'
  ($scope) ->
    unless $load.views['conversation-options'] is true
      $load.views['conversation-options'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/conversation-options/conversation-options.css'
    restrict: 'C'
    templateUrl: 'views/conversation-options/conversation-options.html'
    link: (scope, $el) ->
      conversationOptions = $el[0]

]

app.directive 'selectProviders', [
  '$rootScope'
  '$timeout'
  ($scope, $timeout) ->
    restrict: 'C'
    link: (scope, $el) ->
      selectProviders = $el[0]
      selectProviders.on 'click', (e) ->
        e.preventDefault()
        $timeout =>
          $event.focus = @
          $scope.menu = 'providers'
        $scope.apply()
        console.log 'meh!'


]
