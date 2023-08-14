#!/bin/bash

# Check if HandleLidSwitch is set to ignore in logind.conf
if grep -q '^[[:space:]]*#*[[:space:]]*HandleLidSwitch=.*' /etc/systemd/logind.conf; then
    # Remove any comment and add HandleLidSwitch=ignore
    sudo sed -i 's/^[[:space:]]*#*[[:space:]]*HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
else
    # Add HandleLidSwitch=ignore to logind.conf
    echo "HandleLidSwitch=ignore" | sudo tee -a /etc/systemd/logind.conf
fi

# Restart the systemd daemon to apply the changes
sudo systemctl restart systemd-logind

echo "Laptop lid close action configured to do nothing."
