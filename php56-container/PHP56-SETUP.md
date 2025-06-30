# PHP 5.6 Remote Container Setup

This setup allows you to run PHP 5.6 code remotely in a separate container while working in your PHP 7.4 devcontainer.

## Quick Start (Run from Local Terminal)

**Important**: Run these commands from your local terminal, NOT inside the devcontainer!

### 1. Start the PHP 5.6 Container
```bash
# From your local terminal in the project directory
./start-php56.sh
```

### 2. Test version-test.php in PHP 5.6
```bash
# Run the test script in PHP 5.6
./run-php56-test.sh
```

### 3. Access via Web Browser
- PHP 5.6 container: http://localhost:8056/version-test.php
- PHP 7.4 devcontainer: http://localhost/version-test.php

## Container Details

- **Image**: php:5.6-apache
- **Port**: 8056 (to avoid conflicts with the devcontainer on port 80)
- **Volume Mount**: `./source` → `/var/www/html`
- **Container Name**: php56-legacy

## Available Commands

### Start/Stop Containers
```bash
# Start PHP 5.6 container
docker-compose up -d php56-legacy

# Stop PHP 5.6 container
docker-compose down php56-legacy

# Stop all containers
docker-compose down
```

### Execute PHP Commands
```bash
# Run a specific PHP file
docker exec php56-legacy php /var/www/html/version-test.php

# Interactive PHP shell
docker exec -it php56-legacy php -a

# Access container bash
docker exec -it php56-legacy bash
```

### Check Container Status
```bash
# List running containers
docker ps

# View PHP 5.6 container logs
docker logs php56-legacy

# Follow logs in real-time
docker logs -f php56-legacy
```

## File Structure

```
source/                 # Your PHP source files (mapped to both containers)
├── version-test.php    # Test script to verify PHP versions
└── ...                 # Your other PHP files

.devcontainer/          # PHP 7.4 devcontainer config
docker-compose.yml      # Multi-container setup
start-php56.sh         # Helper script to start PHP 5.6
run-php56-test.sh      # Helper script to test PHP 5.6
```

## Development Workflow

1. **Edit code** in VS Code (devcontainer with PHP 7.4)
2. **Test in PHP 7.4** via http://localhost or debugging
3. **Test in PHP 5.6** via http://localhost:8056 or CLI commands
4. **Compare results** between PHP versions

## Troubleshooting

### Container won't start
```bash
# Check if port 8056 is in use
netstat -tulpn | grep 8056

# Check Docker logs
docker logs php56-legacy
```

### Files not showing up
```bash
# Verify volume mount
docker exec php56-legacy ls -la /var/www/html

# Check source folder exists
ls -la ./source/
```

### Permission issues
```bash
# Fix permissions on source folder
chmod -R 755 ./source/
```
