#!/bin/bash
# Helper script to start PHP 5.6 container from local terminal
# Run this from your local terminal, not inside the devcontainer
# Usage: cd php56-setup && ./start-php56.sh

set -e

echo "Starting PHP 5.6 legacy container..."

# Check if docker-compose is available
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
else
    echo "Error: Neither docker-compose nor 'docker compose' is available"
    exit 1
fi

echo "Using: $COMPOSE_CMD"

# Make sure we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "Error: docker-compose.yml not found. Make sure you're running this from the php56-setup directory."
    exit 1
fi

# Start only the PHP 5.6 container
$COMPOSE_CMD up -d php56-legacy

# Wait a moment for the container to start
sleep 3

# Check if container is running
if docker ps | grep -q php56-legacy; then
    echo "✅ PHP 5.6 container is running!"
    echo "📁 Source folder mapped to /var/www/html"
    echo "🌐 Web server available at: http://localhost:8056"
    echo ""
    echo "Container details:"
    docker ps --filter "name=php56-legacy" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
    echo ""
    echo "To test, try:"
    echo "  curl http://localhost:8056/version-test.php"
    echo "  or visit http://localhost:8056/version-test.php in your browser"
    echo ""
    echo "To run PHP commands in the container:"
    echo "  docker exec -it php56-legacy php /var/www/html/version-test.php"
else
    echo "❌ Failed to start PHP 5.6 container"
    echo "Checking logs..."
    docker-compose logs php56-legacy
fi
