#!/bin/bash

# Create the service file
sudo tee /etc/systemd/system/enable-console-blanking.service > /dev/null << EOF
[Unit]
Description=Enable virtual console blanking

[Service]
Type=oneshot
Environment=TERM=linux
StandardOutput=tty
TTYPath=/dev/console
ExecStart=/usr/bin/setterm -blank 1

[Install]
WantedBy=multi-user.target
EOF

# Set permissions for the service file
sudo chmod 664 /etc/systemd/system/enable-console-blanking.service

# Enable the service
sudo systemctl enable enable-console-blanking.service

echo "Operations completed successfully."
