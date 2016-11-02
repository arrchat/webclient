# profile-settings view

app.directive 'profileSettings', [
  '$rootScope'
  ($scope) ->
    unless $load.views['profile-settings'] is true
      $load.views['profile-settings'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/profile-settings/profile-settings.css'
    restrict: 'C'
    templateUrl: 'views/profile-settings/profile-settings.html'
    link: (scope, $el) ->
      profileSettings = $el[0]

]
