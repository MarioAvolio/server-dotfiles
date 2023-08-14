#!/bin/bash

# Update package lists
sudo apt update

# Install UFW (Uncomplicated Firewall)
sudo apt install -y ufw

# Deny all incoming and allow all outgoing traffic (default policy)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH connections
sudo ufw allow ssh

# Allow FTP connections (both control and data connections)
sudo ufw allow 21/tcp

# Allow HTTP and HTTPS connections
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable UFW
sudo ufw enable

echo "UFW installation and configuration completed successfully."
