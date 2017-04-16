const rimraf = require('rimraf');
const pug = require('pug');

const debug = true;

module.exports = function gruntfile(grunt) {
  grunt.initConfig({
    babel: {
      options: {
        sourceMap: false,
        presets: ['latest'],
        plugins: [
          ['module-resolver', {
            root: ['app/'],
            alias: {
              vuejs: `vue/dist/vue${!debug ? '.min.js' : '.js'}`,
            },
          }],
        ],
      },
      app: {
        files: [{
          expand: true,
          cwd: 'app',
          src: ['**/*.js', '!arrchat.js'],
          dest: '.dist/assets/js/',
        }],
      },
      arrchat: {
        files: [{
          expand: true,
          cwd: '.dist/assets/js/',
          src: 'arrchat.js',
          dest: '.dist/assets/js/',
        }],
      },
      views: {
        files: [{
          expand: true,
          cwd: 'views',
          src: ['**/index.js', '!index/index.js'],
          dest: '.dist/assets/js/views/',
          rename: (dest, src) => {
            const path = src.split('/');
            path.pop();
            path.unshift(dest);
            return `${path.join('/')}.js`;
          },
        }],
      },
    },
    browserify: {
      options: {
        banner: '// arrchat :3\n// https://github.com/arrchat',
        browserifyOptions: {
          debug,
        },
      },
      files: {
        expand: true,
        cwd: '.dist/assets/js/',
        src: ['*.js'],
        dest: '.dist/assets/js/',
      },
    },
    stylus: {
      compile: {
        files: {
          '.dist/assets/style/style.css': 'views/**/index.styl',
        },
        options: {
          compress: !debug,
          import: ['nib'],
        },
      },
    },
    pug: {
      index: {
        files: {
          '.dist/index.html': 'views/index/index.pug',
        },
      },
    },
  });

  grunt.loadNpmTasks('grunt-babel');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-stylus');
  grunt.loadNpmTasks('grunt-contrib-pug');

  grunt.registerTask('cleanup', () => {
    rimraf.sync('.dist');
  });

  grunt.registerTask('prepare', () => {
    let content = grunt.file.read('app/arrchat.js')
      .replace(/(\ *)?\/\/ Load views/, (_, spaces = '') => {
        let views = `${spaces}const templates = {\n`;

        const cwd = 'views';
        const viewList = grunt.file.expand({ cwd }, ['*', '!index']);
        for (let view of viewList) {
          views += `${spaces}  '${view}': '${pug.renderFile(`views/${view}/index.pug`, {})}',\n`;
        }

        views += `${spaces}}\n`;
        for (let view of viewList) {
          views += `\n${spaces}require('./views/${view}.js');`;
        }

        return views;
      });

    grunt.file.write('.dist/assets/js/arrchat.js', content);
  });

  grunt.registerTask('build', ['default']);

  grunt.registerTask('default', [
    'cleanup',
    'prepare',
    'babel',
    'browserify',
    'stylus',
    'pug',
  ]);
};
