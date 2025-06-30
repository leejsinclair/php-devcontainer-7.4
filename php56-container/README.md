# PHP 5.6 Setup Files

This folder contains all the files needed to run a PHP 5.6 container alongside your PHP 7.4 devcontainer.

## Files

- **`docker-compose.yml`** - Container configuration for both PHP 7.4 and PHP 5.6
- **`start-php56.sh`** - Helper script to start the PHP 5.6 container
- **`run-php56-test.sh`** - Helper script to test PHP files in PHP 5.6
- **`stop-php56.sh`** - Helper script to stop the PHP 5.6 container
- **`PHP56-SETUP.md`** - Complete documentation and usage guide

## Quick Usage

From your local terminal (not inside the devcontainer):

```bash
# Navigate to this directory
cd php56-setup

# Start PHP 5.6 container
./start-php56.sh

# Test PHP files
./run-php56-test.sh

# Stop container when done
./stop-php56.sh
```

## File Locations

- **Source files**: `../source/` (mapped to `/var/www/html` in PHP 5.6 container)
- **Web access**: 
  - PHP 5.6: http://localhost:8056
  - PHP 7.4: http://localhost

For detailed instructions, see `PHP56-SETUP.md`.
