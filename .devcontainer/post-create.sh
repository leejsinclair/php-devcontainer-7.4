#!/bin/bash
set -e

echo "Setting up PHP development environment..."

# Get the vscode user's UID and GID
VSCODE_UID=$(id -u vscode)
VSCODE_GID=$(id -g vscode)

echo "vscode user UID: $VSCODE_UID, GID: $VSCODE_GID"

# Create a symbolic link from Apache's document root to our workspace
sudo rm -rf /var/www/html
sudo ln -sf /workspace/source /var/www/html

# Set up Apache to run with proper permissions
sudo sed -i "s/User www-data/User vscode/" /etc/apache2/apache2.conf
sudo sed -i "s/Group www-data/Group vscode/" /etc/apache2/apache2.conf

# Ensure the workspace has correct permissions
sudo chown -R vscode:vscode /workspace

# Start Apache
sudo service apache2 start

echo "PHP development environment setup complete!"
echo "Apache is running on port 80"
echo "Xdebug is configured on port 9000"
echo "Workspace is at /workspace (mapped to your local project)"
