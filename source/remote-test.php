<?php
// This script demonstrates running PHP in a remote container

echo "=== Remote PHP Execution Test ===\n";
echo "Current container: " . gethostname() . "\n";
echo "PHP version: " . PHP_VERSION . "\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";
echo "Working directory: " . getcwd() . "\n";

// Simple computation
$numbers = range(1, 10);
$sum = array_sum($numbers);
echo "Sum of 1-10: $sum\n";

// Environment info
echo "Environment variables:\n";
foreach ($_ENV as $key => $value) {
    if (strpos($key, 'PHP') === 0 || strpos($key, 'PATH') === 0) {
        echo "  $key = $value\n";
    }
}

echo "=== Test completed ===\n";
