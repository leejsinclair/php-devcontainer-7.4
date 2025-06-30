<?php
// Test script to show PHP version and features
echo "PHP Version: " . phpversion() . "\n";
echo "PHP SAPI: " . php_sapi_name() . "\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";

// Test array syntax - using PHP 5.3 compatible syntax first
$array_old = array(1, 2, 3, 4, 5);
echo "Array (PHP 5.3+ syntax): " . implode(', ', $array_old) . "\n";

// Test if we can use short array syntax (PHP 5.4+)
if (version_compare(PHP_VERSION, '5.4.0') >= 0) {
    echo "PHP 5.4+ features available!\n";
    // Use eval to safely test short array syntax
    $short_array_code = '$array_new = array(6, 7, 8, 9, 10);';
    eval($short_array_code);
    echo "Array (fallback syntax): " . implode(', ', $array_new) . "\n";
} else {
    echo "This is PHP 5.3 or lower - no short array syntax\n";
}

// Test if this is PHP 7+
if (version_compare(PHP_VERSION, '7.0.0') >= 0) {
    echo "This is PHP 7 or higher - modern features available!\n";

    // Use ternary operator instead of null coalescing for compatibility
    $test = null;
    $result = ($test !== null) ? $test : 'default value';
    echo "Null check result: $result\n";
} else {
    echo "This is PHP 5.x - legacy compatibility mode\n";

    // PHP 5.x compatible null check
    $test = null;
    $result = isset($test) ? $test : 'default value';
    echo "Legacy null check result: $result\n";
}

// Show more version details safely
$version_parts = explode('.', PHP_VERSION);
echo "PHP Major Version: " . $version_parts[0] . "\n";
echo "PHP Minor Version: " . $version_parts[1] . "\n";
echo "Extensions loaded: " . count(get_loaded_extensions()) . "\n";

echo "Script completed successfully!\n";
echo "Extensions loaded: " . count(get_loaded_extensions()) . "\n";

echo "Script completed successfully!\n";
