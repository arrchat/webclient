class SessionStorage extends require './storage'
  save: ->
    localStorage.addItem 'profiles', JSON.stringify @profiles
module.exports = SessionStorage
