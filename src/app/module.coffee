global = global or window
global.app = angular.module 'arrchat', [ ]

global.$dom =
  html: q 'html'
  head: q 'head'
  body: q 'body'
global.$load =
  views: {}

<% dirs.forEach(function(dir){ %>
require '<%= dir %>'
<% }) %>
