#!/bin/bash
# Helper script to execute PHP scripts in the PHP 5.6 container from within the devcontainer
# Usage: ./run-in-php56.sh script-name.php [args...]

set -e

SCRIPT_NAME="$1"
shift
SCRIPT_ARGS="$@"

if [ -z "$SCRIPT_NAME" ]; then
    echo "Usage: $0 <script-name.php> [args...]"
    echo ""
    echo "Examples:"
    echo "  $0 remote-test.php"
    echo "  $0 version-test-clean.php"
    echo "  $0 simple-test.php"
    exit 1
fi

# Check if the script exists in the source folder
if [ ! -f "/workspace/source/$SCRIPT_NAME" ]; then
    echo "Error: Script '$SCRIPT_NAME' not found in /workspace/source/"
    echo "Available scripts:"
    ls -1 /workspace/source/*.php 2>/dev/null || echo "  No PHP scripts found"
    exit 1
fi

echo "🐘 Executing $SCRIPT_NAME in PHP 5.6 container..."
echo "======================================================"

# Check if PHP 5.6 container is running
if ! docker ps --format '{{.Names}}' | grep -q '^php56-legacy$'; then
    echo "❌ PHP 5.6 container (php56-legacy) is not running!"
    echo ""
    echo "Start it first from your local terminal:"
    echo "  cd php56-setup && ./start-php56.sh"
    echo ""
    echo "Or using docker-compose:"
    echo "  cd php56-setup && docker-compose up -d php56-legacy"
    exit 1
fi

# Execute the script in the PHP 5.6 container
if [ -n "$SCRIPT_ARGS" ]; then
    docker exec php56-legacy php /var/www/html/"$SCRIPT_NAME" $SCRIPT_ARGS
else
    docker exec php56-legacy php /var/www/html/"$SCRIPT_NAME"
fi

echo ""
echo "======================================================"
echo "✅ Execution completed!"
