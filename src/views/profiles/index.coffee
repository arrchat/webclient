# profiles view

app.directive 'profiles', [
  '$rootScope'
  ($scope) ->
    unless $load.views['profiles'] is true
      $load.views['profiles'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/profiles/profiles.css'
    restrict: 'C'
    templateUrl: 'views/profiles/profiles.html'
    link: (scope, $el) ->
      profiles = $el[0]

]
