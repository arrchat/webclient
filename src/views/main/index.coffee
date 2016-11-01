# main view

app.directive 'main', [
  '$rootScope'
  ($scope) ->
    unless $load.views['main'] is true
      $load.views['main'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/main/main.css'
    restrict: 'C'
    templateUrl: 'views/main/main.html'
    link: (scope, $el) ->
      main = $el[0]

]
