<?php

/**
 * Sample PHP file for testing the PHP 7.4 devcontainer with Xdebug 3.x
 */

declare(strict_types=1);

echo "<h1>PHP 7.4 DevContainer with Xdebug 3.x</h1>";
echo "<p>PHP Version: " . phpversion() . "</p>";

// PHP 7.4 features demonstration
class User
{
    public string $name;
    public ?string $email;

    public function __construct(string $name, ?string $email = null)
    {
        $this->name = $name;
        $this->email = $email;
    }

    public function getDisplayName(): string
    {
        return $this->name . ($this->email ? " ({$this->email})" : '');
    }
}

// Arrow functions (PHP 7.4 feature)
$numbers = [1, 2, 3, 4, 5];
$squared = array_map(fn($n) => $n * $n, $numbers);

// Null coalescing assignment operator (PHP 7.4 feature)
$config = [];
$config['debug'] ??= true;
$config['timeout'] ??= 30;

// Test variables for debugging
$users = [
    new User("John Doe", "john@example.com"),
    new User("Jane Smith", "jane@example.com"),
    new User("Bob Wilson")
];

// Function to test debugging
function processUsers(array $users): array
{
    $processed = [];
    foreach ($users as $user) {
        $processed[] = [
            'name' => $user->name,
            'email' => $user->email,
            'display' => $user->getDisplayName()
        ];
    }
    return $processed;
}

// Test the function
$processedUsers = processUsers($users);

echo "<h2>Users:</h2><ul>";
foreach ($processedUsers as $userData) {
    echo "<li>{$userData['display']}</li>";
}
echo "</ul>";

echo "<h2>Squared Numbers (Arrow Function Demo):</h2><ul>";
foreach ($squared as $index => $value) {
    echo "<li>{$numbers[$index]}² = $value</li>";
}
echo "</ul>";

echo "<h2>Configuration:</h2>";
echo "<pre>" . print_r($config, true) . "</pre>";

// Test error handling (uncomment to test)
// throw new Exception("This is a test exception for debugging");

echo "<h2>Xdebug Status:</h2>";
if (extension_loaded('xdebug')) {
    echo "<p style='color: green;'>✓ Xdebug is loaded and ready!</p>";
    echo "<p>Xdebug Version: " . phpversion('xdebug') . "</p>";
    echo "<p>Xdebug Mode: " . (ini_get('xdebug.mode') ?: 'Not set') . "</p>";
} else {
    echo "<p style='color: red;'>✗ Xdebug is not loaded</p>";
}

echo "<h2>PHP 7.4 Features Demonstrated:</h2>";
echo "<ul>";
echo "<li>✓ Typed Properties (User class)</li>";
echo "<li>✓ Arrow Functions (array_map with fn())</li>";
echo "<li>✓ Null Coalescing Assignment (??=)</li>";
echo "<li>✓ Strict Types Declaration</li>";
echo "</ul>";

phpinfo();
