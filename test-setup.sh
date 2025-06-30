#!/bin/bash
echo "=== PHP DevContainer Test ==="
echo

echo "1. User Information:"
echo "Current user: $(whoami)"
echo "User ID: $(id -u)"
echo "Group ID: $(id -g)"
echo "Home directory: $HOME"
echo

echo "2. PHP Information:"
php --version
echo "PHP modules: $(php -m | wc -l) loaded"
echo "Xdebug status: $(php -m | grep -i xdebug || echo 'Not loaded')"
echo

echo "3. Apache Status:"
if service apache2 status > /dev/null 2>&1; then
    echo "Apache: Running"
else
    echo "Apache: Not running"
fi
echo

echo "4. File Permissions:"
echo "Workspace permissions:"
ls -la /workspace/ | head -5
echo

echo "5. Network Connectivity:"
echo "Can reach localhost:80: $(curl -s http://localhost > /dev/null && echo 'Yes' || echo 'No')"
echo

echo "6. Composer:"
composer --version 2>/dev/null || echo "Composer not found"
echo

echo "=== Test Complete ===" 
