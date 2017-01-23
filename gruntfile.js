const rimraf = require('rimraf');

module.exports = function gruntfile(grunt) {
  grunt.initConfig({
    babel: {
      options: {
        sourceMap: false,
        presets: ['es2017'],
      },
      files: {
        expand: true,
        cwd: 'app',
        src: ['**/*.js'],
        dest: '.dist',
      },
    },
    browserify: {
      options: {
        banner: '// arrchat :3\n// https://github.com/arrchat',
        browserifyOptions: {
          debug: true,
        },
      },
      files: {
        expand: true,
        cwd: '.dist',
        src: ['*.js'],
        dest: '.dist',
      },
    },
  });

  grunt.loadNpmTasks('grunt-babel');
  grunt.loadNpmTasks('grunt-browserify');

  grunt.registerTask('cleanup', () => {
    rimraf.sync('.dist');
  });

  grunt.registerTask('build', ['default']);

  grunt.registerTask('default', [
    'cleanup',
    'babel',
    'browserify',
  ]);
};
