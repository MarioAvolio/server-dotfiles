#!/bin/bash

# Save this script to a file (e.g., setup_cleaning.sh), make it executable (chmod +x setup_cleaning.sh), and then run it with the desired action:

# To install the automatic server cleaning: sudo ./setup_cleaning.sh install_cleaning
# To uninstall the automatic server cleaning: sudo ./setup_cleaning.sh uninstall_cleaning
# Please review and understand the script before using it, and consider backing up your system before making significant changes.

# Function to install automatic server cleaning
install_cleaning() {
    # Cleaning script content
    CLEAN_SCRIPT_CONTENT="
    #!/bin/bash

    # Update package lists
    sudo apt update

    # Remove unnecessary packages
    sudo apt autoremove --purge -y

    # Clean APT cache
    sudo apt clean

    # Clean thumbnail cache
    rm -r ~/.cache/thumbnails/*

    # Clean temporary files
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*

    # Clean package manager cache
    sudo apt-get clean

    # Remove old kernel versions (keep the latest one)
    sudo apt purge \$(dpkg --list | grep '^rc' | awk '{ print \$2 }')

    # Clean journal logs
    sudo journalctl --vacuum-time=7d

    echo 'Server cleaning completed.'
    "

    # Create the cleaning script in the user's home folder
    CLEAN_SCRIPT_PATH="$HOME/clean_server.sh"
    echo "$CLEAN_SCRIPT_CONTENT" > "$CLEAN_SCRIPT_PATH"
    chmod +x "$CLEAN_SCRIPT_PATH"

    # Add cron job to run the cleaning script daily at 3:00 AM
    (crontab -l 2>/dev/null; echo "0 3 * * * $CLEAN_SCRIPT_PATH") | crontab -

    echo "Automatic server cleaning script and cron job configured."
}

# Function to uninstall automatic server cleaning
uninstall_cleaning() {
    # Remove the cleaning script
    CLEAN_SCRIPT_PATH="$HOME/clean_server.sh"
    rm -f "$CLEAN_SCRIPT_PATH"

    # Remove the cron job
    crontab -l | grep -v "$CLEAN_SCRIPT_PATH" | crontab -

    echo "Automatic server cleaning script and cron job uninstalled."
}

# Main script
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [install_cleaning | uninstall_cleaning]"
    exit 1
fi

case "$1" in
    install_cleaning)
        install_cleaning
        ;;
    uninstall_cleaning)
        uninstall_cleaning
        ;;
    *)
        echo "Usage: $0 [install_cleaning | uninstall_cleaning]"
        exit 1
        ;;
esac
