#!/bin/bash

# Update package lists
sudo apt update

# Install i3wm and related packages
sudo apt install -y i3 i3status i3lock dmenu

# Install LightDM display manager
sudo apt install -y lightdm

# Set i3 as the default window manager for your user
if ! grep -q "exec i3" ~/.xinitrc; then
    echo "exec i3" >> ~/.xinitrc
fi

# Configure LightDM for autologin
AUTLOGIN_CONF_PATH="/etc/lightdm/lightdm.conf.d/60-lightdm-autologin.conf"
if [ ! -d "$(dirname "$AUTLOGIN_CONF_PATH")" ]; then
    sudo mkdir -p "$(dirname "$AUTLOGIN_CONF_PATH")"
fi

if ! grep -q "#autologin-user=" "$AUTLOGIN_CONF_PATH" || ! grep -q "#autologin-user-timeout=0" "$AUTLOGIN_CONF_PATH"; then
    sudo sed -i '/#autologin-user=/s/^#//' "$AUTLOGIN_CONF_PATH"
    sudo sed -i '/#autologin-user-timeout=0/s/^#//' "$AUTLOGIN_CONF_PATH"
fi

if ! grep -q "\[Seat:\*\]" "$AUTLOGIN_CONF_PATH"; then
    echo -e "[Seat:*]\nautologin-user=$(whoami)\nautologin-user-timeout=0" | sudo tee -a "$AUTLOGIN_CONF_PATH"
else
    sudo sed -i '/\[Seat:\*\]/a autologin-user=$(whoami)\nautologin-user-timeout=0' "$AUTLOGIN_CONF_PATH"
fi

# Enable LightDM
sudo systemctl enable lightdm

echo "i3wm installation, LightDM configuration, and autologin setup completed successfully."
