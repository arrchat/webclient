global = global or window
global.app = angular.module 'arrchat', [ ]

<% dirs.forEach(function(dir){ %>
require '<%= dir %>'
<% }) %>
