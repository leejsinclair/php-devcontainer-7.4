#!/bin/bash
# Interactive task launcher for PHP environment management

echo "🐘 PHP Environment Manager"
echo "=========================="
echo ""

# Show current status
echo "📊 Current Status:"
/workspace/.devcontainer/scripts/switch-php-version.sh status
echo ""

echo "Available Actions:"
echo "1) Switch to PHP 7.4"
echo "2) Switch to PHP 5.6 (settings only)"
echo "3) Check environment status"
echo "4) Start PHP 5.6 container (HOST terminal required)"
echo "5) Stop PHP 5.6 container (HOST terminal required)"
echo "6) Run test in PHP 5.6"
echo "7) Test Docker access"
echo "8) Exit"
echo ""

read -p "Select an option (1-8): " choice

case $choice in
    1)
        echo "🔄 Switching to PHP 7.4..."
        /workspace/.devcontainer/scripts/switch-php-version.sh php74
        echo ""
        echo "💡 Don't forget to reload VS Code: Ctrl+Shift+P → 'Developer: Reload Window'"
        ;;
    2)
        echo "🔄 Switching to PHP 5.6 settings..."
        /workspace/.devcontainer/scripts/switch-php-version.sh php56
        echo ""
        echo "💡 Don't forget to reload VS Code: Ctrl+Shift+P → 'Developer: Reload Window'"
        echo ""
        echo "⚠️  To start PHP 5.6 container, use HOST terminal:"
        echo "   cd php56-setup && ./start-php56.sh"
        ;;
    3)
        /workspace/.devcontainer/scripts/switch-php-version.sh status
        ;;
    4)
        echo "⚠️  Container management requires HOST terminal!"
        echo "This devcontainer cannot directly manage other containers."
        echo ""
        echo "From your HOST terminal (not devcontainer):"
        echo "1. Navigate to your project directory"
        echo "2. Run: cd php56-setup && ./start-php56.sh"
        ;;
    5)
        echo "⚠️  Container management requires HOST terminal!"
        echo "This devcontainer cannot directly manage other containers."
        echo ""
        echo "From your HOST terminal (not devcontainer):"
        echo "1. Navigate to your project directory"
        echo "2. Run: cd php56-setup && ./stop-php56.sh"
        ;;
    6)
        echo "🧪 Running test in PHP 5.6..."
        /workspace/php56-connectivity/run-in-php56.sh version-test-clean.php
        ;;
    7)
        echo "🔍 Testing Docker access..."
        /workspace/php56-connectivity/test-docker-access.sh
        ;;
    8)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid option. Please select 1-8."
        exit 1
        ;;
esac
