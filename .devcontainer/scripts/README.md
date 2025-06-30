# DevContainer Scripts

This folder contains development scripts for the PHP devcontainer environment.

## Scripts

### PHP Version Management
- **`switch-php-version.sh`** - Switch VS Code between PHP 7.4 and PHP 5.6 configurations
- **`php56-wrapper.sh`** - Wrapper script that routes PHP commands to the PHP 5.6 container
- **`php-env-manager.sh`** - Interactive script for managing PHP environments

## Usage

### Switch PHP Versions
```bash
# Check current PHP configuration
./.devcontainer/scripts/switch-php-version.sh status

# Switch to PHP 7.4
./.devcontainer/scripts/switch-php-version.sh php74

# Switch to PHP 5.6 
./.devcontainer/scripts/switch-php-version.sh php56
```

### Interactive Manager
```bash
# Launch interactive environment manager
./.devcontainer/scripts/php-env-manager.sh
```

### VS Code Integration
These scripts are integrated with VS Code tasks. Use:
- **Command Palette** → "Tasks: Run Task" → Select PHP task
- **Keyboard shortcuts** (see main README.md)

## Notes

- Scripts in this folder are meant to be run from within the devcontainer
- Container management (start/stop PHP 5.6) must be done from the HOST terminal
- After switching PHP versions, reload VS Code: `Ctrl+Shift+P` → "Developer: Reload Window"
