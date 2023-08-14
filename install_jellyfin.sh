#!/bin/bash

# Update package lists
sudo apt update

# Install necessary packages
sudo apt install -y apt-transport-https wget gnupg

# Add Jellyfin repository GPG key
wget -O - https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | sudo apt-key add -

# Add Jellyfin repository
echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/debian $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list > /dev/null

# Update package lists again
sudo apt update

# Install Jellyfin Media Server
sudo apt install -y jellyfin

# Enable Jellyfin to start on boot
sudo systemctl enable jellyfin

echo "Jellyfin Media Server installation and auto-start configuration completed."
