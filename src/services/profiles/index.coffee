Profile = require './profile'
# profiles service
app.factory 'profiles', [
  '$rootScope'
  'storage'
  'crypt'
  ($scope, $storage, $crypt) ->
    profiles = {}
    # profiles service logic

    profiles.new = ->
      $scope.profile = new Profile $storage, $crypt
      $scope.main = 'profile'


    profiles
]
