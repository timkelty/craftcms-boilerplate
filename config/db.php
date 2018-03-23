<?php
use fusionary\craftcms\bootstrap\helpers\Config;

/**
 * @see https://github.com/timkelty/craftcms-bootstrap               Bootstrap docs
 * @see vendor/craftcms/cms/src/config/DbConfig.php                  Available settings
 * @see https://github.com/craftcms/docs/blob/v3/en/configuration.md Craft config docs
 */
return Config::mapConfig([
    'server' => null,
    'user' => null,
    'password' => null,
    'database' => null,
    'port' => null,
], 'DB_');
