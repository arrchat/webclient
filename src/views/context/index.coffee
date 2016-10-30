# context view

app.directive 'contextMenu', [
  '$rootScope'
  'context'
  ($scope, $context) ->
    restrict: 'A'
    link: (scope, $el, $attr) ->
      context = $el[0]
      context.on 'contextmenu', (e) ->
        e.preventDefault()
        $context.open $attr.contextMenu, scope[$attr.contextMenu]
        false
]

app.directive 'context', [
  '$rootScope'
  ($scope, $context) ->
    unless $load.views['context'] == !0
      $load.views['context'] = !0
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/context/context.css'
    restrict: 'C'
    templateUrl: 'views/context/context.html'
    link: (scope, $el) ->
      context = $el[0]
      
]
