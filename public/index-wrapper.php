<?php
// Error suppression wrapper for Rota Management System
error_reporting(E_ERROR | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING);
ini_set('display_errors', 'Off');
ini_set('display_startup_errors', 'Off');
ini_set('log_errors', 'On');
ini_set('error_log', '/tmp/php_errors.log');

// Include the main application
require_once 'index.php';
?> 