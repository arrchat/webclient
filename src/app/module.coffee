global = global or window
global.app = angular.module 'onechat', [ ]

<% dirs.forEach(function(dir){ %>
require '<%= dir %>'
<% }) %>
