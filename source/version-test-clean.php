<?php
// Clean PHP 5.6 compatible version test script
echo "=== PHP Version Test ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "PHP SAPI: " . php_sapi_name() . "\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";

// Use only PHP 5.3 compatible syntax throughout
$numbers = array(1, 2, 3, 4, 5);
echo "Array test: " . implode(', ', $numbers) . "\n";

// Version comparison
$is_php7_or_higher = version_compare(PHP_VERSION, '7.0.0') >= 0;
$is_php54_or_higher = version_compare(PHP_VERSION, '5.4.0') >= 0;

if ($is_php7_or_higher) {
    echo "This is PHP 7 or higher!\n";

    // Safe way to test PHP 7 features without using them directly
    echo "Modern PHP features would be available here\n";
} else {
    echo "This is PHP 5.x - legacy mode\n";

    if ($is_php54_or_higher) {
        echo "PHP 5.4+ features available\n";
    } else {
        echo "PHP 5.3 or lower\n";
    }
}

// Null handling - PHP 5.x way
$test_var = null;
if (isset($test_var)) {
    $result = $test_var;
} else {
    $result = 'default value';
}
echo "Null check result: " . $result . "\n";

// Version details
$version_info = explode('.', phpversion());
echo "Major version: " . $version_info[0] . "\n";
echo "Minor version: " . $version_info[1] . "\n";

// Extension count
echo "Loaded extensions: " . count(get_loaded_extensions()) . "\n";

// Memory usage
echo "Memory usage: " . memory_get_usage() . " bytes\n";

echo "=== Test completed successfully! ===\n";
