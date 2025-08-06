<?php
// Simple test to check if PHP is working
error_reporting(E_ERROR | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING);
ini_set('display_errors', 'Off');
ini_set('display_startup_errors', 'Off');

echo "=== Rota Management System Test ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Status: Application is running!\n";

// Check if config files exist
$configFiles = ['database.php', 'auth.php', 'email.php', 'recording.php'];
echo "\nConfiguration Files:\n";
foreach ($configFiles as $file) {
    $path = __DIR__ . '/../config/' . $file;
    echo "- $file: " . (file_exists($path) ? "✓ EXISTS" : "✗ MISSING") . "\n";
}

// Test database connection
echo "\nDatabase Connection:\n";
try {
    $pdo = new PDO('mysql:host=mysql.railway.internal;dbname=railway', 'root', 'cRyfgtFAITBVWVNPkYFksVZDMSBvsgBo');
    echo "✓ Database connection: SUCCESS\n";

    $stmt = $pdo->query('SELECT COUNT(*) FROM cr_settings');
    $count = $stmt->fetchColumn();
    echo "✓ Settings count: $count\n";
} catch (Exception $e) {
    echo "✗ Database connection: FAILED - " . $e->getMessage() . "\n";
}

echo "\n=== Application Ready ===\n";
echo "Your Rota Management System is now running!\n";
echo "Visit /test.php for detailed diagnostics.\n";
?> 