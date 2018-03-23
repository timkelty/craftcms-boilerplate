const {Neutrino} = require('neutrino');

// Specify middleware to Neutrino prior to calling eslintrc.
// Even if using .neutrinorc.js, you must specify it when using
// the API
module.exports = Neutrino()
  .use('.neutrinorc.js')
  .call('eslintrc');
