# profile-create view

app.directive 'profileCreate', [
  '$rootScope'
  '$timeout'
  'profiles'
  ($scope, $timeout, $profiles) ->
    unless $load.views['profile-create'] is true
      $load.views['profile-create'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/profile-create/profile-create.css'
    restrict: 'C'
    templateUrl: 'views/profile-create/profile-create.html'
    link: (scope, $el) ->
      profileCreate = $el[0]
      profileCreate.on 'click', (e) ->
        $scope.menu = ''
        $timeout ->
          $profiles.new()
]
