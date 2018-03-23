if (module.hot) {
  module.hot.accept();
}

import './css/index.scss';
import * as myModule from './js/my-module.js';

myModule.init();
