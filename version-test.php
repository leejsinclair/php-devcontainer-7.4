<?php
// Test script to show PHP version and features
echo "PHP Version: " . phpversion() . "\n";
echo "PHP SAPI: " . php_sapi_name() . "\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";

// Test array syntax (PHP 5.4+ feature)
$array = [1, 2, 3, 4, 5];
echo "Array (PHP 5.4+ syntax): " . implode(', ', $array) . "\n";

// Test if this is PHP 7+
if (version_compare(PHP_VERSION, '7.0.0') >= 0) {
    echo "This is PHP 7 or higher - modern features available!\n";

    // Try to use null coalescing operator (PHP 7+ feature)
    $test = null;
    $result = $test ?? 'default value';
    echo "Null coalescing operator result: $result\n";
} else {
    echo "This is PHP 5.x - legacy compatibility mode\n";

    // PHP 5.x compatible null check
    $test = null;
    $result = isset($test) ? $test : 'default value';
    echo "Legacy null check result: $result\n";
}

echo "Script completed successfully!\n";
