<?php
// API endpoint to execute scripts remotely in PHP 5.6 container
// Access via: http://localhost:8056/execute-api.php?script=remote-test.php

header('Content-Type: text/plain');
header('Access-Control-Allow-Origin: *');

// Get the script parameter
$script = $_GET['script'] ?? '';

if (empty($script)) {
    http_response_code(400);
    echo "Error: No script specified. Use ?script=filename.php\n";
    exit;
}

// Sanitize the script name (security measure)
$script = basename($script);
if (!preg_match('/^[a-zA-Z0-9_-]+\.php$/', $script)) {
    http_response_code(400);
    echo "Error: Invalid script name. Only alphanumeric, dash, underscore, and .php extension allowed.\n";
    exit;
}

$script_path = "/var/www/html/$script";

// Check if script exists
if (!file_exists($script_path)) {
    http_response_code(404);
    echo "Error: Script '$script' not found.\n";
    exit;
}

echo "=== Executing $script in PHP 5.6 Container ===\n";
echo "Container: " . gethostname() . "\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Timestamp: " . date('Y-m-d H:i:s') . "\n";
echo "==========================================\n\n";

// Capture output
ob_start();

try {
    // Include and execute the script
    include $script_path;
} catch (Exception $e) {
    echo "Error executing script: " . $e->getMessage() . "\n";
} catch (Error $e) {
    echo "Fatal error executing script: " . $e->getMessage() . "\n";
}

$output = ob_get_clean();
echo $output;

echo "\n==========================================\n";
echo "Execution completed at " . date('Y-m-d H:i:s') . "\n";
