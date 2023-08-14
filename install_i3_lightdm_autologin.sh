#!/bin/bash

# Update package lists
sudo apt update

# Install i3wm and related packages
sudo apt install -y i3 i3status i3lock dmenu

# Install LightDM display manager
sudo apt install -y lightdm

# Set i3 as the default window manager for your user
echo "exec i3" > ~/.xinitrc

# Configure LightDM for autologin
sudo tee /etc/lightdm/lightdm.conf.d/60-lightdm-autologin.conf > /dev/null << EOF
[SeatDefaults]
autologin-user=<your_username>
autologin-user-timeout=0
EOF

# Enable LightDM
sudo systemctl enable lightdm

echo "i3wm installation, LightDM configuration, and autologin setup completed successfully."
