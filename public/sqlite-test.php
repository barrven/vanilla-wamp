<?php
$dir = __DIR__ . '/data';  // Relative to script, e.g., /var/www/html/public/data
if (!is_dir($dir)) {
    mkdir($dir, 0755, true);
}
try {
    $db = new PDO('sqlite:' . $dir . '/app.db');
    $db->exec("CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY)");
    echo "SQLite connected and table created successfully!";
} catch (PDOException $e) {
    die("SQLite failed: " . $e->getMessage());
}
?>