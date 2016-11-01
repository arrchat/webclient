# message view

app.directive 'message', [
  '$rootScope'
  '$timeout'
  ($scope, $timeout) ->
    unless $load.views['message'] is true
      $load.views['message'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/message/message.css'
    restrict: 'C'
    templateUrl: 'views/message/message.html'
    scope:
      userId: '@'
    link: (scope, $el, $attr) ->
      message = $el[0]

      $el[0].on '$destroy', ->
        message.next.class.remove 'next' if message.next

      $timeout ->
        if message.prev? and $attr.userId == message.prev.attr 'user-id'
            message.class.add 'next'

]
