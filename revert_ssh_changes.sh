#!/bin/bash

# Revert "PermitRootLogin" change
sudo sed -i 's/PermitRootLogin no/#PermitRootLogin yes/' /etc/ssh/sshd_config

# Revert "PasswordAuthentication" change
sudo sed -i 's/PasswordAuthentication no/#PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart the SSH service to apply the changes
sudo systemctl restart sshd

echo "SSH configuration changes reverted to original settings."
