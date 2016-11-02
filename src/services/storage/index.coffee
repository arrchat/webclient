# storage service

storages = {}

app.factory 'storage', [
  '$rootScope'
  '$window'
  ($scope) ->
    storage = {}
    # storage service logic

    storage.save = ->
      new waff.Promise (f, r) ->
        saved = 0
        for store, stored of storage
          storages[store + 'Storage'].save stored
            .then ->
              if ++saved is Object.keys(storages).length
                f()
            .catch (err) ->
              r err

    $scope.$on '$locationChangeStart', (e, n) ->
      storage.save()
        .then ->
          # TODO
          # change location by hand
          null # fix for unexpected dot below
        .catch ->
          # TODO
          # display error

    storage
]
