#!/bin/bash

# Save this script to a file (e.g., setup_firewall.sh), make it executable (chmod +x setup_firewall.sh), and then run it with the desired action:

# To install the specific firewall configuration: sudo ./setup_firewall.sh install_firewall
# To uninstall the specific firewall configuration: sudo ./setup_firewall.sh uninstall_firewall
# To install UFW and default rules: sudo ./setup_firewall.sh install_ufw
# Please review and understand the script before using it, and consider backing up your system before making significant changes.

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Function to install firewall configuration
install_firewall() {
    # Enable UFW (Uncomplicated Firewall)
    ufw enable

    # Allow incoming traffic for Transmission
    ufw allow 9091/tcp

    # Allow incoming traffic for Plex
    ufw allow 32400/tcp
    ufw allow 32469/udp

    # Allow incoming traffic for Jellyfin
    ufw allow 8096/tcp

    # Allow incoming traffic for Pi-hole (DNS)
    ufw allow 53/tcp
    ufw allow 53/udp

    # Allow incoming traffic for Cockpit
    ufw allow 9090/tcp

    # Reload UFW rules
    ufw reload

    echo "Firewall configuration for Transmission, Plex, Jellyfin, Pi-hole, and Cockpit installed."
}

# Function to uninstall firewall configuration
uninstall_firewall() {
    # Reset UFW rules
    ufw --force reset

    echo "Firewall configuration for Transmission, Plex, Jellyfin, Pi-hole, and Cockpit uninstalled."
}

# Function to install UFW and default rules
install_ufw() {
    # Update package lists
    apt update

    # Install UFW (Uncomplicated Firewall)
    apt install -y ufw

    # Deny all incoming and allow all outgoing traffic (default policy)
    ufw default deny incoming
    ufw default allow outgoing

    # Allow SSH connections
    ufw allow ssh

    # Allow FTP connections (both control and data connections)
    ufw allow 21/tcp

    # Allow HTTP and HTTPS connections
    ufw allow 80/tcp
    ufw allow 443/tcp

    # Enable UFW
    ufw enable

    echo "UFW installation and default configuration completed."
}

# Main script
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [install_firewall | uninstall_firewall | install_ufw]"
    exit 1
fi

case "$1" in
    install_firewall)
        install_firewall
        ;;
    uninstall_firewall)
        uninstall_firewall
        ;;
    install_ufw)
        install_ufw
        ;;
    *)
        echo "Usage: $0 [install_firewall | uninstall_firewall | install_ufw]"
        exit 1
        ;;
esac
