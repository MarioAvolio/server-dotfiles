#!/bin/bash

# Check if HandleLidSwitch is set to ignore in logind.conf
if grep -q '^HandleLidSwitch=ignore' /etc/systemd/logind.conf; then
    echo "Laptop lid close action is already configured to do nothing."
else
    # Add or update HandleLidSwitch to ignore in logind.conf
    sudo sed -i '/^#*HandleLidSwitch=/s/=.*/=ignore/' /etc/systemd/logind.conf

    # Restart the systemd daemon to apply the changes
    sudo systemctl restart systemd-logind

    echo "Laptop lid close action configured to do nothing."
fi
