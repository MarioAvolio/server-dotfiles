#!/bin/bash

# Open logind.conf in a text editor
sudo nano /etc/systemd/logind.conf

# If HandleLidSwitch is not set to ignore, change it to ignore
# Make sure it's not commented out (remove # if present)
# If the line is missing, add it at the end of the file
echo "Configuring logind.conf..."
sed -i '/^#*HandleLidSwitch=/s/=.*/=ignore/' /etc/systemd/logind.conf

# Restart the systemd daemon to apply the changes
echo "Restarting systemd-logind service..."
sudo systemctl restart systemd-logind

echo "Laptop lid close action configured to do nothing."
