# profiles view

app.directive 'profiles', [
  '$rootScope'
  ($scope) ->
    restrict: 'C'
    link: (scope, $el) ->
      profiles = $el[0]

]
