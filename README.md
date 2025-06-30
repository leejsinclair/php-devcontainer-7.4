# PHP Development Container

A complete PHP 7.4 development environment with Xdebug 3.x in a VS Code devcontainer. This setup provides seamless file editing, debugging, and proper user permissions.

## Features

- **PHP 7.4** with common extensions (GD, ZIP, MySQL, etc.)
- **Xdebug 3.x** for debugging
- **Apache 2** web server
- **Composer** for dependency management
- **Automatic user mapping** for seamless file editing
- **VS Code integration** with recommended extensions

## Quick Start

1. **Prerequisites:**
   - VS Code with the Dev Containers extension
   - Docker Desktop or Docker Engine

2. **Open in Container:**
   ```bash
   # Clone or navigate to this project
   cd php-devcontainer
   
   # Open in VS Code
   code .
   
   # Use Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
   # Run: "Dev Containers: Reopen in Container"
   ```

3. **Wait for setup** - The container will build and configure automatically

4. **Start developing:**
   - Edit PHP files in your workspace
   - Access your app at http://localhost
   - Debug with F5 or the debug panel

## What's Included

### Development Environment
- PHP 7.4 with extensions: `gd`, `zip`, `intl`, `xml`, `mysql`, `opcache`
- Apache 2 web server with mod_rewrite enabled
- Xdebug 3.1.6 for debugging and profiling
- Composer for package management

### VS Code Integration
- **PHP Debug** extension for Xdebug integration
- **PHP Intelephense** for intelligent code completion
- **JSON** extension for configuration files
- Proper debug configurations for Xdebug 3.x

### User & Permissions
- Uses VS Code's `common-utils` feature for automatic user mapping
- Your local user UID/GID are preserved in the container
- No permission issues when editing files
- Apache runs with your user permissions

## File Structure

```
.devcontainer/
├── devcontainer.json    # Main devcontainer configuration
├── Dockerfile.php70     # PHP 7.4 container definition
├── php74.ini           # PHP/Xdebug configuration
└── post-create.sh      # Setup script (auto-run)

.vscode/
├── launch.json         # Debug configurations
└── settings.json       # PHP-specific VS Code settings

test.php               # Sample PHP file for testing
```

## Usage

### Web Development
- Place your PHP files in the project root
- They'll be accessible at http://localhost
- Apache document root points to your workspace via symlink

### Debugging
1. Set breakpoints in your PHP code
2. Press F5 or use the Debug panel
3. Choose "Listen for Xdebug 3.x"
4. Navigate to your PHP page in the browser
5. Debugging will start automatically

### Command Line
```bash
# Run PHP scripts
php test.php

# Use Composer
composer install
composer require vendor/package

# Check PHP configuration
php -m              # List loaded modules
php --ini          # Show configuration files
```

## Configuration

### PHP Settings
Edit `.devcontainer/php74.ini` to customize PHP configuration:
- Memory limits
- Upload sizes
- Xdebug settings
- Extension configuration

### Apache Configuration
The setup includes:
- Document root: `/workspace` (your project folder)
- mod_rewrite enabled
- Runs on port 80
- User permissions match your local user

### Xdebug Configuration
Pre-configured for VS Code with:
- Port 9000 (standard)
- Client host: `host.docker.internal`
- Debug mode enabled
- Step debugging and profiling support

## Troubleshooting

### Container won't start
```bash
# Check Docker is running
docker ps

# Rebuild container
# Command Palette → "Dev Containers: Rebuild Container"
```

### Permission issues
The new setup should eliminate permission issues, but if you encounter any:
```bash
# Check user mapping
id

# Verify workspace permissions
ls -la /workspace
```

### Debugging not working
1. Verify Xdebug is loaded: `php -m | grep xdebug`
2. Check port 9000 is free on your host
3. Ensure VS Code PHP Debug extension is installed
4. Try "Dev Containers: Rebuild Container"

### Apache issues
```bash
# Check Apache status
sudo service apache2 status

# Restart Apache
sudo service apache2 restart

# Check Apache logs
sudo tail -f /var/log/apache2/error.log
```

## Migration from Previous Setup

If you're updating from the old `www-data` hardcoded setup:
1. The new setup uses dynamic user mapping
2. Workspace is now at `/workspace` instead of `/var/www/html`
3. File permissions should work seamlessly
4. Rebuild the container to apply changes

## Development Notes

- **PHP Version:** 7.4 (stable, well-supported)
- **Xdebug Version:** 3.1.6 (compatible with PHP 7.4)
- **User Approach:** Dynamic mapping via devcontainers/common-utils
- **Web Root:** Symbolic link from `/var/www/html` to `/workspace`
- **Permissions:** Apache runs as your user, eliminating permission issues
