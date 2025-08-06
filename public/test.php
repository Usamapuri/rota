<?php
// Simple test script to debug Railway deployment
echo "=== PHP Test Script ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Current directory: " . __DIR__ . "\n";

// Check if config files exist
$configFiles = ['database.php', 'auth.php', 'email.php', 'recording.php'];
foreach ($configFiles as $file) {
    $path = __DIR__ . '/../config/' . $file;
    echo "Config file $file: " . (file_exists($path) ? "EXISTS" : "MISSING") . "\n";
}

// Test database connection
echo "\n=== Database Test ===\n";
try {
    $pdo = new PDO('mysql:host=mysql.railway.internal;dbname=railway', 'root', 'cRyfgtFAITBVWVNPkYFksVZDMSBvsgBo');
    echo "Database connection: SUCCESS\n";
    
    $stmt = $pdo->query('SELECT COUNT(*) FROM cr_settings');
    $count = $stmt->fetchColumn();
    echo "Settings count: $count\n";
} catch (Exception $e) {
    echo "Database connection: FAILED - " . $e->getMessage() . "\n";
}

// Test if main application files exist
echo "\n=== Application Files Test ===\n";
$appFiles = [
    'index.php',
    '../src/settings.php',
    '../src/dependencies.php',
    '../src/middleware.php',
    '../src/routes.php'
];

foreach ($appFiles as $file) {
    $path = __DIR__ . '/' . $file;
    echo "File $file: " . (file_exists($path) ? "EXISTS" : "MISSING") . "\n";
}

// Test autoloader
echo "\n=== Autoloader Test ===\n";
if (file_exists(__DIR__ . '/../vendor/autoload.php')) {
    echo "Vendor autoload: EXISTS\n";
    try {
        require_once __DIR__ . '/../vendor/autoload.php';
        echo "Autoloader: LOADED SUCCESSFULLY\n";
    } catch (Exception $e) {
        echo "Autoloader: FAILED - " . $e->getMessage() . "\n";
    }
} else {
    echo "Vendor autoload: MISSING\n";
}

echo "\n=== Test Complete ===\n";
?> 