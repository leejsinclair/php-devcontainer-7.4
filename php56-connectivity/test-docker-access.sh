#!/bin/bash
# Test script to check Docker access from within the devcontainer

echo "🔍 Testing Docker access from devcontainer..."
echo ""

# Check if docker command exists
if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker command is available"
    
    # Check if we can connect to Docker daemon
    if docker ps >/dev/null 2>&1; then
        echo "✅ Docker daemon is accessible"
        
        # List running containers
        echo ""
        echo "📋 Currently running containers:"
        docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
        
        # Check specifically for PHP 5.6 container
        if docker ps --format '{{.Names}}' | grep -q '^php56-legacy$'; then
            echo ""
            echo "✅ PHP 5.6 container (php56-legacy) is running!"
            echo "🧪 You can now use ./run-in-php56.sh to execute scripts"
        else
            echo ""
            echo "ℹ️  PHP 5.6 container is not running"
            echo "   Start it from your local terminal: cd php56-setup && ./start-php56.sh"
        fi
    else
        echo "❌ Cannot connect to Docker daemon"
        echo "   Make sure Docker is running on your host system"
    fi
else
    echo "❌ Docker command not found"
    echo "   You may need to rebuild the devcontainer to get Docker access"
    echo "   VS Code Command: 'Dev Containers: Rebuild Container'"
fi

echo ""
echo "🏁 Docker access test completed!"
