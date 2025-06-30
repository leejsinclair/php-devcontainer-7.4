#!/bin/bash
# Script to switch VS Code between PHP 7.4 and PHP 5.6 configurations

SETTINGS_FILE="/workspace/.vscode/settings.json"
PHP74_BACKUP="/workspace/.vscode/settings-php74.json"
PHP56_SETTINGS="/workspace/.vscode/settings-php56.json"

show_usage() {
    echo "Usage: $0 [php74|php56|status]"
    echo ""
    echo "Commands:"
    echo "  php74   - Switch to PHP 7.4 configuration"
    echo "  php56   - Switch to PHP 5.6 configuration"
    echo "  status  - Show current PHP configuration"
    echo ""
}

get_current_php_version() {
    if [ -f "$SETTINGS_FILE" ]; then
        if grep -q "5\.6\.0" "$SETTINGS_FILE"; then
            echo "PHP 5.6"
        elif grep -q "7\.4\.0" "$SETTINGS_FILE"; then
            echo "PHP 7.4"
        else
            echo "Unknown"
        fi
    else
        echo "No settings file found"
    fi
}

switch_to_php74() {
    echo "🔄 Switching VS Code to PHP 7.4..."
    
    # Backup current settings if it's not already PHP 7.4
    if [ -f "$SETTINGS_FILE" ] && ! grep -q "7\.4\.0" "$SETTINGS_FILE"; then
        cp "$SETTINGS_FILE" "${SETTINGS_FILE}.backup"
    fi
    
    # Create PHP 7.4 settings if backup doesn't exist
    if [ ! -f "$PHP74_BACKUP" ]; then
        cat > "$PHP74_BACKUP" << 'EOF'
{
    "php.validate.executablePath": "/usr/local/bin/php",
    "php.debug.executablePath": "/usr/local/bin/php",
    "php.suggest.basic": false,
    "intelephense.environment.phpVersion": "7.4.0",
    "intelephense.format.enable": true,
    "editor.formatOnSave": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "files.associations": {
        "*.php": "php"
    },
    "emmet.includeLanguages": {
        "php": "html"
    }
}
EOF
    fi
    
    cp "$PHP74_BACKUP" "$SETTINGS_FILE"
    echo "✅ Switched to PHP 7.4"
    echo "   - PHP executable: /usr/local/bin/php (devcontainer)"
    echo "   - IntelliSense: PHP 7.4 features enabled"
}

switch_to_php56() {
    echo "🔄 Switching VS Code to PHP 5.6..."
    
    # Check if PHP 5.6 container is running
    if ! docker ps --format '{{.Names}}' | grep -q '^php56-legacy$' 2>/dev/null; then
        echo "⚠️  Warning: PHP 5.6 container (php56-legacy) is not running"
        echo "   Start it first: cd php56-setup && ./start-php56.sh"
        echo ""
        echo "   Proceeding with configuration anyway..."
    fi
    
    # Backup current settings if it's not already PHP 5.6
    if [ -f "$SETTINGS_FILE" ] && ! grep -q "5\.6\.0" "$SETTINGS_FILE"; then
        cp "$SETTINGS_FILE" "${SETTINGS_FILE}.backup"
    fi
    
    if [ ! -f "$PHP56_SETTINGS" ]; then
        echo "❌ Error: PHP 5.6 settings file not found at $PHP56_SETTINGS"
        exit 1
    fi
    
    cp "$PHP56_SETTINGS" "$SETTINGS_FILE"
    echo "✅ Switched to PHP 5.6"
    echo "   - PHP executable: /workspace/php56-wrapper.sh (container wrapper)"
    echo "   - IntelliSense: PHP 5.6 compatibility mode"
    echo ""
    echo "💡 You may need to reload VS Code for changes to take effect:"
    echo "   Command Palette → 'Developer: Reload Window'"
}

show_status() {
    echo "📊 Current VS Code PHP Configuration:"
    echo "   Version: $(get_current_php_version)"
    
    if [ -f "$SETTINGS_FILE" ]; then
        echo "   Executable: $(grep -o '"php.validate.executablePath": "[^"]*"' "$SETTINGS_FILE" | cut -d'"' -f4)"
        echo "   Settings file: $SETTINGS_FILE"
    fi
    
    echo ""
    echo "🐳 Container Status:"
    if docker ps --format '{{.Names}}' | grep -q '^php56-legacy$' 2>/dev/null; then
        echo "   PHP 5.6 container: ✅ Running"
    else
        echo "   PHP 5.6 container: ❌ Not running"
    fi
}

# Main logic
case "${1:-status}" in
    "php74")
        switch_to_php74
        ;;
    "php56")
        switch_to_php56
        ;;
    "status")
        show_status
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
