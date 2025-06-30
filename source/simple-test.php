<?php
// Simple PHP 5.6 compatibility test
echo "=== PHP 5.6 Compatibility Test ===\n";
echo "PHP Version: " . phpversion() . "\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";

// Use only PHP 5.3 compatible syntax
$numbers = array(1, 2, 3, 4, 5);
echo "Array sum: " . array_sum($numbers) . "\n";

// Test basic string operations
$greeting = "Hello";
$target = "PHP 5.6";
echo $greeting . " " . $target . "!\n";

// Test basic conditionals
if (version_compare(PHP_VERSION, '5.6.0') >= 0) {
    echo "PHP 5.6 or higher detected\n";
} else {
    echo "PHP version is below 5.6\n";
}

// Test function definition
function multiply($a, $b)
{
    return $a * $b;
}

echo "5 * 3 = " . multiply(5, 3) . "\n";

echo "=== Test completed successfully! ===\n";
