const browsers = require('browserslist')();
const {basename} = require('path');

// Load .env vars
const dotenv = require('dotenv').config();

module.exports = {
  options: {
    output: 'public/build',
  },
  use: neutrino => {
    neutrino.use('@neutrinojs/web', {
      html: false,
      publicPath: `/${basename(neutrino.options.output)}/`,
      devServer: {
        proxy: process.env.DEV_SERVER_PROXY,
      },
      targets: {browsers},
      style: {
        test: /\.s?css$/,
        modulesTest: /\.module\.s?css$/,
        loaders: [
          {
            useId: 'postcss',
            loader: require.resolve('postcss-loader'),
            options: {
              config: {
                path: neutrino.options.root,
                ctx: {
                  basePath: neutrino.options.source
                }
              },
            },
          }
        ]
      },
      minify: {
        babel: {
          removeConsole: true,
          removeDebugger: true
        }
      },
    });

    neutrino.use('@neutrinojs/eslint', {
      eslint: {
        baseConfig: {
          extends: '@fusionary/eslint-config',
        }
      }
    });

    neutrino.use('@neutrinojs/stylelint');

    neutrino.config.module
      .when(process.env.NODE_ENV === 'development', module => {
        module.rule('jquery')
          .test(require.resolve('jquery'))
          .use('jquery')
            .loader('expose-loader')
            .options('$');
      });

  }
};
