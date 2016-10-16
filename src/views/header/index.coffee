# header view
console.log 'meh!'
app.directive 'header', [
  '$rootScope'
  ($scope) ->
    restrict: 'C'
    templateUrl: 'views/header/header.html'
    link: (scope, $el) ->
      header = $el[0]

]
