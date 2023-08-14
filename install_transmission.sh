#!/bin/bash

# Update package lists
sudo apt update

# Install Transmission and its dependencies
sudo apt install -y transmission-daemon

# Stop the Transmission service
sudo systemctl stop transmission-daemon

# Set your desired username and password
username=$(whoami)
password="your_password"

# Configure Transmission settings
sudo sed -i 's/"rpc-authentication-required".*/"rpc-authentication-required": true,/' /etc/transmission-daemon/settings.json
sudo sed -i 's/"rpc-username".*/"rpc-username": "'$username'",/' /etc/transmission-daemon/settings.json
sudo sed -i 's/"rpc-password".*/"rpc-password": "'$password'",/' /etc/transmission-daemon/settings.json

# Change ownership of Transmission's download directory
sudo chown -R $username: /var/lib/transmission-daemon/downloads

# Start the Transmission service
sudo systemctl start transmission-daemon

# Enable Transmission service to start at boot
sudo systemctl enable transmission-daemon

echo "Transmission server installation and setup completed successfully."
