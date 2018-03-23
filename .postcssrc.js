const merge = require('deepmerge');

module.exports = ({options}) => merge(require('@fusionary/postcss-config/scss')({options}), {
  // Project-level customizations
  plugins: {
  }
});
