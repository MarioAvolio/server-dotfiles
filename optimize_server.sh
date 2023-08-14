#!/bin/bash

# Update package lists and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Optimize swappiness (1 for server workloads)
echo "vm.swappiness=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Disable unnecessary services
sudo systemctl disable bluetooth
sudo systemctl disable avahi-daemon
sudo systemctl disable cups

# Configure TCP keepalive settings
echo "net.ipv4.tcp_keepalive_time = 1200" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Install and configure Unattended-Upgrades for automatic security updates
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# Enable and configure UFW firewall with basic rules
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Configure SSH security
sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Server optimizations completed."
