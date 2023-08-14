#!/bin/bash

# Enable UFW (Uncomplicated Firewall)
sudo ufw enable

# Allow incoming traffic for Transmission
sudo ufw allow 9091/tcp

# Allow incoming traffic for Plex
sudo ufw allow 32400/tcp
sudo ufw allow 32469/udp

# Allow incoming traffic for Jellyfin
sudo ufw allow 8096/tcp

# Allow incoming traffic for Pi-hole (DNS)
sudo ufw allow 53/tcp
sudo ufw allow 53/udp

# Allow incoming traffic for Cockpit
sudo ufw allow 9090/tcp

# Reload UFW rules
sudo ufw reload

echo "Firewall configuration for Transmission, Plex, Jellyfin, Pi-hole, and Cockpit completed."
