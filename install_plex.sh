#!/bin/bash

# Update package lists
sudo apt update

# Install necessary packages
sudo apt install -y apt-transport-https ca-certificates curl

# Add Plex repository GPG key
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo gpg --dearmor -o /usr/share/keyrings/plex-archive-keyring.gpg

# Add Plex repository
echo "deb [signed-by=/usr/share/keyrings/plex-archive-keyring.gpg] https://downloads.plex.tv/repo/deb public main" | sudo tee /etc/apt/sources.list.d/plex.list > /dev/null

# Update package lists again
sudo apt update

# Install Plex Media Server
sudo apt install -y plexmediaserver

# Enable Plex Media Server to start on boot
sudo systemctl enable plexmediaserver

echo "Plex Media Server installation and auto-start configuration completed."
