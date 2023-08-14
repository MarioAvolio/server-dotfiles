#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y curl

# Download and install Node.js (required for code-server)
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Download and extract Visual Studio Code Server
curl -fsSL -o codeserver.tar.gz https://github.com/cdr/code-server/releases/latest/download/code-server-latest-linux-x86_64.tar.gz
tar -xvf codeserver.tar.gz

# Move code-server to /usr/local/bin and create a symbolic link
sudo mv code-server-*-linux-x86_64 /usr/local/bin/code-server
sudo ln -s /usr/local/bin/code-server /usr/local/bin/code-server

# Clean up downloaded files
rm codeserver.tar.gz

# Create systemd service for code-server
sudo tee /etc/systemd/system/code-server.service > /dev/null << EOF
[Unit]
Description=Visual Studio Code Server
After=network.target

[Service]
Type=simple
Environment=PASSWORD=your_password
ExecStart=/usr/local/bin/code-server --bind-addr 0.0.0.0:8080 --auth password

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start code-server service
sudo systemctl daemon-reload
sudo systemctl enable code-server.service
sudo systemctl start code-server.service

echo "Visual Studio Code Server installation and service setup completed successfully."
