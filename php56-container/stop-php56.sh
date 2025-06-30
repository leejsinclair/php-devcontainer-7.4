#!/bin/bash
# Helper script to stop PHP 5.6 container
# Run this from your local terminal, not inside the devcontainer
# Usage: cd php56-setup && ./stop-php56.sh

set -e

echo "Stopping PHP 5.6 container..."

# Check if docker-compose is available
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
elif command -v docker &> /dev/null && docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
else
    echo "Error: Neither docker-compose nor 'docker compose' is available"
    exit 1
fi

# Make sure we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "Error: docker-compose.yml not found. Make sure you're running this from the php56-setup directory."
    exit 1
fi

# Stop and remove the container
$COMPOSE_CMD down php56-legacy

echo "✅ PHP 5.6 container stopped and removed"

# Show remaining containers
echo ""
echo "Remaining containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
