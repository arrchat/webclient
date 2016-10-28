# main view

app.directive 'main', [
  '$rootScope'
  ($scope) ->
    unless $load.views['main'] == !0
      $load.views['main'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/main/main.css'
    restrict: 'C'
    templateUrl: 'views/main/main.html'
    link: (scope, $el) ->
      main = $el[0]

]
