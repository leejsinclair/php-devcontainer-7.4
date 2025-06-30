# PHP 7.4 DevContainer - Troubleshooting Guide

## ✅ CURRENT SOLUTION: PHP 7.4 with Xdebug 3.x

**Problem Solved:** Repository issues with older PHP versions resolved by using PHP 7.4.

**Current Setup:**
- **Base Image:** `php:7.4-apache` with fixed Debian Bullseye repositories
- **Xdebug:** Version 3.1.6 (modern, fast, VS Code optimized)
- **PHP Extensions:** All modern extensions without compatibility issues

## Migration from PHP 5.6 to 7.4

### Key Changes Made:
1. **Updated Base Image:** From PHP 5.6 to PHP 7.4
2. **Xdebug Upgrade:** From 2.x to 3.x (better performance, modern config)
3. **Extension Updates:** Removed deprecated extensions (mcrypt)
4. **Configuration:** Updated to Xdebug 3.x syntax

### Benefits of PHP 7.4:
- **Performance:** 2-3x faster than PHP 5.6
- **Modern Features:** Typed properties, arrow functions, null coalescing assignment
- **Better Support:** Active maintenance and security updates
- **No Repository Issues:** Uses actively maintained Debian repositories

### 2. PECL/Xdebug Installation Errors
**Error:** `pecl: command not found` or Xdebug compilation errors

**Solution:**
- Using official PHP image includes PECL by default
- Xdebug 2.5.5 is pre-tested with this base image

### 3. Build Context Issues
**Error:** `COPY failed: no such file or directory`

**Solution:**
- Ensure `php.ini` exists in `.devcontainer/` folder
- Check that `devcontainer.json` has correct build context

### 4. Permission Errors
**Error:** Permission denied errors when accessing files

**Solution:**
- Container runs as `www-data` user by default
- Files are owned by `www-data:www-data`

### 5. Port Conflicts
**Error:** Port 80 or 9000 already in use

**Solution:**
- Stop other web servers: `sudo service apache2 stop`
- Kill processes using ports: `sudo lsof -ti:80 | xargs kill -9`

## Build Process

### Step 1: Clean Build
```bash
# Remove any existing containers
docker system prune -a

# Rebuild devcontainer
Ctrl+Shift+P -> "Remote-Containers: Rebuild Container"
```

### Step 2: Manual Build (for debugging)
```bash
cd .devcontainer
docker build -t php56-debug .
docker run -p 80:80 -p 9000:9000 php56-debug
```

### Step 3: Verify Build
```bash
# Check PHP version
docker exec -it <container_id> php -v

# Check Xdebug installation
docker exec -it <container_id> php -m | grep xdebug

# Check Apache status
docker exec -it <container_id> service apache2 status
```

## Alternative Configurations

### Option 1: Ubuntu-based (if needed)
If you specifically need Ubuntu base, use `Dockerfile.ubuntu`:

```dockerfile
FROM ubuntu:18.04
# ... see alternative configuration
```

### Option 2: Different PHP Version
For PHP 7.0+ with better support:

```dockerfile
FROM php:7.0-apache
# Xdebug 2.9.8 for PHP 7.0+
RUN pecl install xdebug-2.9.8
```

## Testing the Setup

### 1. Basic PHP Test
Visit: `http://localhost/test.php`

### 2. Xdebug Test
1. Set breakpoint in VS Code
2. Start debugger (F5)
3. Visit: `http://localhost/test.php?XDEBUG_SESSION_START=VSCODE`

### 3. CLI Test
```bash
php -v
php -m | grep xdebug
```

## Current Configuration Benefits

✅ **Reliable Base**: Official PHP Docker image
✅ **Pre-built Extensions**: No compilation needed
✅ **Tested Xdebug**: Version 2.5.5 confirmed working
✅ **VS Code Ready**: All extensions pre-configured
✅ **Fast Build**: Fewer layers, better caching

## If Build Still Fails

1. **Check Docker Resources**: Ensure sufficient RAM (4GB+)
2. **Update Docker**: Use latest Docker Desktop version
3. **Clear Cache**: `docker system prune -a`
4. **Check Network**: Ensure internet access for package downloads
5. **Alternative Base**: Try `php:5.6-fpm` if Apache issues persist

## Support

If you continue experiencing issues:
1. Share the complete error message
2. Include your Docker version: `docker --version`
3. Include your system: `uname -a`
