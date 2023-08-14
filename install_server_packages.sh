#!/bin/bash

# Update package lists
sudo apt update

# Install essential packages
sudo apt install -y \
    openssh-server \
    ufw \
    fail2ban \
    wget \
    curl \
    git \
    nano \
    htop \
    tmux \
    net-tools \
    software-properties-common \
    unzip \
    zip \
    rsync \
    build-essential \
    python3 \
    python3-pip

echo "Essential packages installation completed successfully."
