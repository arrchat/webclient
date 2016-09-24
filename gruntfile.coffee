module.exports = (grunt) ->
  json = grunt.file.readJSON 'package.json'
  rimraf = require 'rimraf'
  coffee = require 'coffee-script'
  ejs = require 'ejs'
  fs = require 'fs'
  glob = require 'glob'


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
          dirs: (->
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
          )()
    stylus:
      compile:
        files: [
            cwd: '.tmp'
            src: '**/*.styl'
            dest: 'dist'
            expand: true
            ext: '.css'
        ]
      options:
        compress: false
        import: [ 'nib' ]
    coffee:
      compile:
        cwd: '.tmp'
        src: '**/*.coffee'
        dest: 'dist'
        expand: true
        ext: '.js'
      options:
        bare: true




  grunt.loadNpmTasks 'grunt-ejs'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'cleanup', ->
    rimraf.sync 'dist'
  grunt.registerTask 'tmp', ->
    rimraf.sync '.tmp'

  grunt.registerTask 'compile', [
    'ejs'
    'stylus'
    'coffee'
    'tmp'
  ]

  grunt.registerTask 'default', [
    'cleanup'
    'compile'
    'browserify'
    'uglify'
  ]
