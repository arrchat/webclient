const rimraf = require('rimraf');
const pug    = require('pug');
const path   = require('path');

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
          '.dist/assets/style/style.css': 'views/*/index.styl',
        },
        options: {
          compress: !debug,
          import: ['nib'],
          paths: ['style/'],
          define: {
            asset: function (file) {
              const f = [];
              const path = this.filename.split('/');
              for (let i = 0; i < path.length - 1; ++i) f.push('..');
              f.push('assets', file.string);
              return new (require('stylus/lib/nodes/string'))(`url(${f.join('/')})`, '');
            },
          },
        },
      },
    },
    pug: {
      options: {
        data: { debug },
        pretty: debug,
      },
      index: {
        files: {
          '.dist/index.html': 'views/index/index.pug',
        },
      },
    },
    favicons: {
      options: {
        regular: true,
        firefox: false,
        apple: false,
        windowsTile: false,
      },
      target: {
        src: 'assets/favicon.svg',
        dest: '.dist/assets/favicons/'
      },
    },
    watch: {
      options: {
        livereload: {
          host: 'localhost',
          port: 35729,
        },
      },
      pug: {
        files: ['views/**/*.pug', '!views/index/*.pug', 'app/arrchat.js'],
        tasks: ['prepare', 'babel:arrchat', 'browserify'],
      },
      index: {
        files: ['views/index/*.pug'],
        tasks: ['pug'],
      },
      styles: {
        files: ['views/**/*.styl'],
        tasks: ['stylus'],
      },
      app: {
        files: ['app/**/*.js', '!app/arrchat.js'],
        tasks: ['babel:app', 'browserify'],
      },
      scripts: {
        files: ['views/**/*.js'],
        tasks: ['babel:views', 'browserify'],
      },
    }
  });

  grunt.loadNpmTasks('grunt-babel');
  grunt.loadNpmTasks('grunt-favicons');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-watch');
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
        const viewList = grunt.file.expand({ cwd }, '*/**/index.js').sort(function (a, b) {
          return a.split('/').length > b.split('/').length;
        }).map(function (e) {
          const s = e.split('/');
          return {
            name: s[s.length - 2],
            path: path.dirname(e),
          };
        });

        for (let view of viewList) {
          const render = pug.renderFile(`views/${view.path}/index.pug`, {});
          views += `${spaces}  '${view.name}': '${render.replace(/\n/g, '\\n')}',\n`;
        }

        views += `${spaces}}\n`;
        for (let view of viewList) {
          views += `\n${spaces}require('./views/${view.path}.js');`;
        }

        return views;
      });

    grunt.file.write('.dist/assets/js/arrchat.js', content);
  });

  grunt.registerTask('assets', () => {
    const files = grunt.file.expand(['assets/*']);
    for (let file of files) {
      grunt.file.copy(`${file}`, `.dist/${file}`);
    }
  });

  grunt.registerTask('build', ['cleanup', 'default', 'favicons']);

  grunt.registerTask('default', [
    'prepare',
    'babel',
    'browserify',
    'stylus',
    'pug',
    'assets',
    'watch',
  ]);
};
