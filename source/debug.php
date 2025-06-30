<?php
// Debug script to check what's causing the parse error
echo "Debug: PHP is working\n";
echo "PHP Version: " . phpversion() . "\n";

// Test each problematic syntax separately
echo "Testing basic arrays...\n";
$test1 = array(1, 2, 3);
echo "Basic array OK\n";

echo "Testing version comparison...\n";
$php_version = phpversion();
echo "Version: " . $php_version . "\n";

if (version_compare($php_version, '5.6.0') >= 0) {
    echo "Version comparison OK\n";
}

echo "Debug completed\n";
