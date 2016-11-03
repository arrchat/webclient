class LocalStorage extends require './storage'
  load: ->
    data = {}
    for k in localStorage.keys()
      data[k] = JSON.parse localStorage.getItem k
    @data = data
  save: ->
    new waff.Promise (f, r) =>
      for k, v of @data
        if v is null
          localStorage.removeItem k
        else
          localStorage.addItem k, JSON.stringify v
      f()
module.exports = LocalStorage
