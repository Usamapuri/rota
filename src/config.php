<?php

require __DIR__.'/../config/database.php';
require __DIR__.'/../config/auth.php';
require __DIR__.'/../config/email.php';
require __DIR__.'/../config/recording.php';

// Set default error reporting for development
$config['displayErrorDetails'] = true;

function getConfig()
{
    global $config;

    return $config;
}
