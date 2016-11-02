global = global or window
global.app = angular.module 'arrchat', [ ]

global.$dom =
  html: q 'html'
  head: q 'head'
  body: q 'body'

global.$load =
  views: {}

global.$debug = true

global.$event =
  focus: null

global.$bang =
  m: 'messenger'
  s: 'steam'

global.$key = Mousetrap

require './util'

<% dirs.forEach(function(dir){ %>
require '<%= dir %>'
<% }) %>

app.filter 'search', [
  '$rootScope'
  ($scope) ->
    (hay) ->
      res = []
      if hay? and hay instanceof Array
        for element in hay
          if $scope.search? and $event.focus is q '.conversation-search'
            query = $scope.search.toLowerCase()
            if $scope.search[0] is '!'
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

app.run [
  '$rootScope'
  'proto'
  ($scope, $proto) ->

    $proto.socket.on 'connect', ->
      connect = new $proto.packet $proto.packet.type.client.get.providers
      connect.send().then (res) ->
        for provider in res.providers
          color = provider.color
          color = 0xFFFFFFFF + +provider.color + 1 if color < 0
          color = color.toString 16
          while color.length < 6
              color = '0' + color
          provider.color = '#' + color
        $scope.providers = res.providers
        $scope.apply()
    global.$blur = (e, f) ->
      if $event.focus? and (f is true or not $event.focus.has e.target)
        document.body.focus()
        $event.focus.class.remove 'focus'
        $event.focus = null
      $scope.menu = 'contacts' unless $scope.menu is 'profiles'
      $scope.context = null if $scope.context?
      $scope.apply()

    document.on 'click', $blur

    $scope.apply = (fn) ->
      if @$root.$$phase is '$apply' or @$root.$$phase is '$digest'
        fn() if fn? and typeof fn is 'function'
      else @$apply fn

    $scope.menu = 'profiles'

    # DEBUG
    $scope.providers = [
        { name: 'messenger', login: 'fb@wvffle.net', contacts: [
          { name: 'JuniorJPDJ' }
          { name: 'Artur' }
          { name: 'arrchat bot' }
          { name: 'waff' }
        ] }
        { name: 'messenger', login: 'waff@wvffle.net', contacts: [
          { name: 'Casper Sewryn' }
          { name: 'Ola' }
          { name: 'Arturina' }
          { name: 'Karolina' }
        ] }
        { name: 'steam', login: 'gaming@wvffle.net', contacts: [
          { name: 'ju-cos-do testu' }
          { name: 'wvffle' }
          { name: 'mehwaff' }
          { name: 'archtur' }
        ] }
    ]
    for provider in $scope.providers
      for contact in provider.contacts
        contact.provider = provider.name.toLowerCase() + ':' + provider.login.toLowerCase()
]
