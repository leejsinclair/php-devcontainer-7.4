#!/bin/bash
# Helper script to run version-test.php in the PHP 5.6 container
# Run this from your local terminal, not inside the devcontainer
# Usage: cd php56-setup && ./run-php56-test.sh

set -e

echo "Running version-test.php in PHP 5.6 container..."

# Check if container is running
if ! docker ps | grep -q php56-legacy; then
    echo "❌ PHP 5.6 container is not running!"
    echo "Start it first with: ./start-php56.sh"
    exit 1
fi

echo "🐘 Executing PHP 5.6 version test..."
echo "----------------------------------------"

# Run the clean version test script
docker exec php56-legacy php /var/www/html/version-test-clean.php

echo "----------------------------------------"
echo "✅ Test completed!"

echo ""
echo "You can also access it via web browser:"
echo "  http://localhost:8056/version-test-clean.php"

echo ""
echo "=== Testing via HTTP request ==="
if command -v curl >/dev/null 2>&1; then
    echo "Making HTTP request to http://localhost:8056/version-test.php"
    curl -s http://localhost:8056/version-test.php
else
    echo "curl not available, install with: apt-get update && apt-get install -y curl"
    echo "You can manually visit: http://localhost:8056/version-test.php"
fi

echo ""
echo "=== Container Information ==="
echo "Container status:"
docker ps --filter "name=php56-legacy" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "PHP version in container:"
docker exec php56-legacy php -v
