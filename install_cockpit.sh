#!/bin/bash

# Update package lists
sudo apt update

# Install Cockpit
sudo apt install -y cockpit

# Enable and start Cockpit service
sudo systemctl enable --now cockpit.socket

echo "Cockpit installation completed."
