global = global or window
global.app = angular.module 'arrchat', [ ]

global.$dom =
  html: q 'html'
  head: q 'head'
  body: q 'body'

global.$load =
  views: {}

global.$event =
  focus: null

<% dirs.forEach(function(dir){ %>
require '<%= dir %>'
<% }) %>

document.on 'click', (e) ->
  if $event.focus? and not $event.focus.has e.target
    $event.focus.class.remove 'focus'
    $event.focus = null

app.filter 'search', [
  '$rootScope'
  ($scope) ->
    (hay) ->
      res = []
      if hay? and hay instanceof Array
        for element in hay
          if $scope.search?
            if ~element.name.toLowerCase().indexOf $scope.search.toLowerCase()
              res.push element
            else if ~element.provider.toLowerCase().indexOf $scope.search.toLowerCase()
              res.push element
          else
            res.push element
      res
]

# DEBUG
app.run [
  '$rootScope'
  ($scope) ->
    $scope.provider =
      messenger: [
        { provider: 'messenger fb@wvffle.net', name: 'name 1'}
        { provider: 'messenger fb@wvffle.net', name: 'name 12'}
        { provider: 'messenger fb@wvffle.net', name: 'name 13'}
        { provider: 'messenger fb@wvffle.net', name: 'name 14'}
      ]
      steam: [
        { provider: 'steam gaming@wvffle.net', name: 'name 15'}
        { provider: 'steam gaming@wvffle.net', name: 'name 16'}
        { provider: 'steam gaming@wvffle.net', name: 'name 17'}
        { provider: 'steam gaming@wvffle.net', name: 'name 18'}
      ]
]
