#!/bin/bash


# Save this script to a file (e.g., security_and_optimization.sh), make it executable (chmod +x security_and_optimization.sh), and then run it with the desired action:

# To install optimizations and security enhancements: sudo ./security_and_optimization.sh install
# To uninstall optimizations and security enhancements: sudo ./security_and_optimization.sh uninstall
# Please note that running the uninstall option will remove the installed packages and undo the configurations. Make sure to review and understand the script before using it, and consider backing up your system before making significant changes.

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Function to install optimizations and security enhancements
install() {
    # Update package lists and upgrade installed packages
    apt update
    apt upgrade -y

    # Optimize swappiness (1 for server workloads)
    echo "vm.swappiness=1" | tee -a /etc/sysctl.conf
    sysctl -p

    # Disable unnecessary services
    systemctl disable bluetooth
    systemctl disable avahi-daemon
    systemctl disable cups

    # Configure TCP keepalive settings
    echo "net.ipv4.tcp_keepalive_time = 1200" | tee -a /etc/sysctl.conf
    sysctl -p

    # Install essential security tools
    apt install -y fail2ban ufw unattended-upgrades apparmor

    # Configure Unattended-Upgrades for automatic security updates
    dpkg-reconfigure -plow unattended-upgrades

    # Enable and configure UFW (Uncomplicated Firewall) with basic rules
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw enable

    # Enable and start Fail2Ban
    systemctl enable fail2ban
    systemctl start fail2ban

    # Configure AppArmor for additional security
    aa-enforce /etc/apparmor.d/*

    # Harden SSH configuration
    sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    systemctl restart sshd

    echo "Server optimizations and security enhancements installed."
}

# Function to uninstall optimizations and security enhancements
uninstall() {
    # Remove installed packages
    apt purge -y fail2ban ufw unattended-upgrades apparmor
    apt autoremove -y

    # Re-enable disabled services
    systemctl enable bluetooth
    systemctl enable avahi-daemon
    systemctl enable cups

    # Remove UFW rules
    ufw --force reset

    # Restore SSH configuration
    sed -i 's/PermitRootLogin.*/#PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/PasswordAuthentication.*/#PasswordAuthentication yes/' /etc/ssh/sshd_config
    systemctl restart sshd

    echo "Server optimizations and security enhancements uninstalled."
}

# Main script
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [install | uninstall]"
    exit 1
fi

case "$1" in
    install)
        install
        ;;
    uninstall)
        uninstall
        ;;
    *)
        echo "Usage: $0 [install | uninstall]"
        exit 1
        ;;
esac
