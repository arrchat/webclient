# select view

app.directive 'select', [
  '$rootScope'
  '$timeout'
  ($scope, $timeout) ->
    unless $load.views['select'] is true
      $load.views['select'] = true
      $dom.head.append e 'link',
        rel: 'stylesheet',
        href: 'views/select/select.css'
    restrict: 'E'
    scope:
      ngModel: '='
    link: (scope, $el) ->
      select = $el[0]
      select.css 'display', 'none'
      cselect = e '.select'
      coptions = e '.options'
      cinput = e 'input', disabled: true

      scope.ngModel = 0 unless scope.ngModel?

      for option, i in select.children
        cinput.value = option.value if i is scope.ngModel
        coption = e '.option', value: i
        coption.text option.value
        coptions.append coption
      cselect.on 'click', (e) ->
        $timeout =>
          if @ is e.target or cinput is e.target
            @class.add 'focus'
            $event.focus = @
          else if e.target.class.has 'option'
            scope.ngModel = +e.target.attr 'value'
            cinput.value = e.target.text()
            e.target = @
            $blur e, true

      cselect.append cinput, coptions
      cselect.after select

]
