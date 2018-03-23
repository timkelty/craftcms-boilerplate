<?php
use fusionary\craftcms\bootstrap\helpers\Config;

/**
 * @see https://github.com/timkelty/craftcms-bootstrap               Bootstrap docs
 * @see vendor/craftcms/cms/src/config/GeneralConfig.php             Available settings
 * @see https://github.com/craftcms/docs/blob/v3/en/configuration.md Configuration docs
 */
return Config::mapMultiEnvConfig([
    '*' => [
        'allowUpdates' => false,
        'cpTrigger' => 'cp',
        'omitScriptNameInUrls' => true,
        'resourceBasePath' => '@webroot/storage/craft',
        'resourceBaseUrl' => '@web/storage/craft',

        # Assuming we are running a queue/listen container
        'runQueueAutomatically' => false,

        'securityKey' => null,
        'siteUrl' => '@web',
        'testToEmailAddress' => null,

        // Custom
        'allowIndexing' => true,
        'allowTracking' => true,
        'devServerProxy' => Config::getHeader('x-dev-server-proxy') ?? false,
    ],
    'local' => [
        'devMode' => true,
        'enableTemplateCaching' => false,
        'allowIndexing' => false,
        'allowTracking' => false,
    ],
    'development' => [
        'allowIndexing' => false,
        'allowTracking' => false,
    ],
    'production' => [

    ],
]);
