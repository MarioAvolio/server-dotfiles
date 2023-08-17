#!/bin/bash

# Prompt for the desired username and password
read -p "Enter the username for Transmission: " username
read -s -p "Enter the password for Transmission: " password
echo

# Update package lists
sudo apt update

# Install Transmission and its dependencies
sudo apt install -y transmission-daemon

# Stop the Transmission service
sudo systemctl stop transmission-daemon

# Transmission settings configuration
transmission_settings="
{
  \"rpc-authentication-required\": true,
  \"rpc-username\": \"$username\",
  \"rpc-password\": \"$password\",
  \"rpc-whitelist\": \"127.0.0.1,192.168.*.*\"
}"
echo "$transmission_settings" | sudo tee /etc/transmission-daemon/settings.json

# Add the user to the "debian-transmission" group
sudo usermod -aG debian-transmission $username

# Change ownership and permissions for the downloads directory
sudo chown -R debian-transmission:debian-transmission /var/lib/transmission-daemon/downloads
sudo chmod -R 755 /var/lib/transmission-daemon/downloads

# Start and enable the Transmission service
sudo systemctl start transmission-daemon
sudo systemctl enable transmission-daemon

echo "Transmission server installation and setup completed successfully."
