#!/bin/bash

# Update package lists and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Install essential security tools
sudo apt install -y fail2ban ufw unattended-upgrades apparmor

# Configure Unattended-Upgrades for automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades

# Configure UFW (Uncomplicated Firewall) with basic rules
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Enable and start Fail2Ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Configure AppArmor for additional security
sudo aa-enforce /etc/apparmor.d/*

# Harden SSH configuration
sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Server security enhancements completed."
