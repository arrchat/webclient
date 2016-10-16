module.exports = (grunt) ->
  json = grunt.file.readJSON 'package.json'
  rimraf = require 'rimraf'
  coffee = require 'coffee-script'
  ejs = require 'ejs'
  fs = require 'fs'
  glob = require 'glob'
  util = require 'util'
  minimatch = require 'minimatch'

  grunt.initConfig
    pkg: json
    browserify:
      app:
        files:
          'dist/app/module.js': 'dist/app/module.js'
          'dist/app/plugin-container.js': 'src/app/plugin-container.coffee'
    uglify:
      app:
        cwd: 'dist'
        src: '**/*.js'
        dest: 'dist'
        expand: true
        ext: '.js'
    ejs:
      stylus:
        files: [
          cwd: 'src'
          src: '**/*.styl'
          dest: '.tmp'
          expand: true
          ext: '.styl'
        ]
        options:
          dirs: (->
            dirs = glob.sync 'src/*'
            exclude = [
              'src/app'
            ]
            dirs = dirs.filter (s) -> -1 == exclude.indexOf s
            res = []
            for dir in dirs
              [].push.apply res, glob.sync dir + '/**/*.styl'
            res
          )()
      coffee:
        files: [
          cwd: 'src'
          src: '**/*.coffee'
          dest: '.tmp'
          expand: true
          ext: '.coffee'
        ]
        options:
          dirs: do ->
            dirs = glob.sync 'src/*'
            exclude = [
              'src/app'
            ]
            dirs = dirs.filter (s) -> -1 == exclude.indexOf s
            res = []
            for dir in dirs
              [].push.apply res, glob.sync dir + '/*/index.coffee'
            for dir in res
              dir = '../../' + dir
                .replace 'src', 'dist'
                .replace /\.coffee$/i, '.js'
    stylus:
      compile:
        files: [
            cwd: '.tmp'
            src: [ '**/*.styl', '!styles/util/**/*.styl' ]
            dest: 'dist'
            expand: true
            ext: '.css'
        ]
      options:
        compress: false
        import: [ 'nib' ]
        paths: [ 'src/styles/util' ]
    coffee:
      compile:
        cwd: '.tmp'
        src: '**/*.coffee'
        dest: 'dist'
        expand: true
        ext: '.js'
      options:
        bare: true
    pug:
      templates:
        options:
           data:  ->
             # index.html dir
             main = 'homepage'
             # scripts loaded after body dir
             after = 'afterload'

             res = obj = {}
             ix = ''

             template =
               css: '<link rel=\'stylesheet\' href=\'%s\'>',
               js:  '<script src=\'%s\'></script>'

             files =
               css: (src) ->
                 grunt.file.expand cwd: 'dist', [
                   'styles/reset.css'
                   'styles/importer.css'
                   'styles/**/*.css'
                 ]
               js: (src) ->
                 grunt.file.expand cwd: 'dist', [
                   'scripts/**/*.js'
                   # folder support
                   unless !src or src.endsWith '.js' then src+'/**/*.js' else '!'+(+new Date)+'.js'
                 ]
               css_bower: (src) ->
                 grunt.file.expand cwd: 'dist', [
                   'bower/**/*.css'
                 ]
               js_bower: (src) ->
                 grunt.file.expand cwd: 'dist', [
                   'bower/**/*.js'
                 ]
             for namespace of files
               type = namespace.split('_')[0]
               itype = namespace.split('_')[1]

               do(namespace, type, itype) ->
                 res[namespace] = (src) ->
                   r = ''
                   obj[namespace] ?= {}
                   obj[namespace].exclude ?= []
                   obj[namespace].files = files[namespace](src)
                   for ex in obj[namespace].exclude
                     index = obj[namespace].files.indexOf ex
                     obj[namespace].files.splice index, 1 unless index == -1
                   unless src?
                     for nfile in obj[namespace].files
                       r += util.format template[type], ix + nfile
                     return r

                   pre = ''
                   nope = src[0] == '!'
                   obj[namespace].files = obj[namespace].files.filter minimatch.filter (if -1 == src.indexOf after then '!' else '')+'scripts/*/' + after + '/**/*.js', {}
                   src += '/**/*.'+type unless src.endsWith '.'+type
                   src = src.slice 1 if nope


                   switch type
                     when 'js'
                       pre += 'scripts/'
                     when 'css'
                       pre += 'styles/'

                   pre += '' + itype + '/' if itype?

                   exclude = obj[namespace].files.filter minimatch.filter pre+'*.'+type, {}
                   exdynamic = obj[namespace].files.filter minimatch.filter pre+src, {}

                   for ex in exdynamic
                     exclude.push ex if -1 == exclude.indexOf ex
                   for ex in exclude
                     index = obj[namespace].files.indexOf ex
                     entry = obj[namespace].files.splice index, 1
                     unless nope
                       obj[namespace].exclude.push entry[0]
                       r += util.format template[type], ix+entry[0]
                   return r
             res
        files: [
          cwd: 'src/templates'
          src: '**/*.pug'
          dest: 'dist'
          expand: true
          ext: '.html'
        ]
      views:
        cwd: 'src/'
        src: 'views/**/*.pug'
        dest: 'dist'
        expand: true
        ext: '.html'

    bower: dev:
      dest: 'dist/bower/'
      options:
        expand: true
    copy: assets: files: [
      expand: true
      cwd: 'src/assets'
      src: [ '**' ]
      dest: 'dist/assets'
    ]




  grunt.loadNpmTasks 'grunt-ejs'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-pug'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bower'

  grunt.registerTask 'cleanup', ->
    rimraf.sync 'dist'
  grunt.registerTask 'tmp', ->
    rimraf.sync '.tmp'

  grunt.registerTask 'compile', [
    'ejs'
    'stylus'
    'coffee'
    'bower'
    'pug'
    'copy'
    'tmp'
  ]

  grunt.registerTask 'default', [
    'tmp'
    'cleanup'
    'compile'
    'browserify'
    'uglify'
  ]
