# header view
app.directive 'header', [
  '$rootScope'
  ($scope) ->
    unless $load.views['header'] == !0
      $load.views['header'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/header/header.css'
    restrict: 'C'
    templateUrl: 'views/header/header.html'
    link: (scope, $el) ->
      header = $el[0]

]
