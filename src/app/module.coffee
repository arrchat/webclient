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

global.$bang =
  m: 'messenger'
  s: 'steam'

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
            query = $scope.search.toLowerCase()
            if $scope.search[0] == '!'
              # bang!
              query = query.split ' '
              bang = query.shift().replace /^!/, ''
              bang = bang.split ':'
              bang[0] = $bang[bang[0]] if $bang[bang[0]]?
              query = query.join ' '
              provider = element.provider.split ':'
              if (provider[0].startsWith bang[0]) and (provider[1].startsWith bang[1] or '') and ~element.name.toLowerCase().indexOf query
                res.push element

            else if ~element.name.toLowerCase().indexOf $scope.search.toLowerCase()
              res.push element
          else
            res.push element
      res
]

# DEBUG
app.run [
  '$rootScope'
  ($scope) ->
    $scope.providers = [
        { name: 'messenger', login: 'fb@wvffle.net', contacts: [
          { name: 'JuniorJPDJ'}
          { name: 'Artur'}
          { name: 'arrchat bot'}
          { name: 'waff'}
        ]}
        { name: 'messenger', login: 'waff@wvffle.net', contacts: [
          { name: 'Casper Sewryn'}
          { name: 'Ola'}
          { name: 'Arturina'}
          { name: 'Karolina'}
        ]}
        { name: 'steam', login: 'gaming@wvffle.net', contacts: [
          { name: 'ju-cos-do testu'}
          { name: 'wvffle'}
          { name: 'mehwaff'}
          { name: 'archtur'}
        ]}
    ]
    for provider in $scope.providers
      for contact in provider.contacts
        contact.provider = provider.name.toLowerCase() + ':' + provider.login.toLowerCase()
    console.log $scope.providers

]
