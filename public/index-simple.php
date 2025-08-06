<?php
// Simple index.php to get the application working
echo "=== Rota Management System ===\n";
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