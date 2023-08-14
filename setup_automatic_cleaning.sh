#!/bin/bash

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

# Create the cleaning script
echo "$CLEAN_SCRIPT_CONTENT" > clean_server.sh
chmod +x clean_server.sh

# Add cron job to run the cleaning script daily at 3:00 AM
(crontab -l 2>/dev/null; echo "0 3 * * * $(pwd)/clean_server.sh") | crontab -

echo "Automatic server cleaning script and cron job configured."
