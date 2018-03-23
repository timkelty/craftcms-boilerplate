<?php
use fusionary\craftcms\bootstrap\helpers\Config;

return [
    'manifestPath' => 'public/build/manifest.json',
    'assetsBasePath' => 'public/build',

    // If devServer we,
    // - don't want to use manifest
    // - want to server our assets from our devServer
    'assetUrlPrefix' => Config::getHeader('x-dev-server-proxy') ? '/build/' : 'build/',
    'pipeline' => Config::getHeader('x-dev-server-proxy') ? 'passthrough' : 'manifest|querystring|passthrough'
];
