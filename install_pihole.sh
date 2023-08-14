#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y curl

# Download and run Pi-hole installer
curl -sSL https://install.pi-hole.net | sudo bash

# Follow the on-screen prompts to complete the installation

echo "Pi-hole installation completed successfully."
