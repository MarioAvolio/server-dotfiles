#!/bin/bash

# Directory to store backups
backup_dir="/path/to/backup/directory"

# Essential system directories to back up
directories_to_backup=(
    "/etc"
    "/var"
    "/boot"
    "/root"
    # Add more directories as needed
)

# Backup file name with timestamp
backup_file="$backup_dir/backup-$(date +%Y%m%d%H%M%S).tar.gz"

# Create the backup
tar czvf $backup_file "${directories_to_backup[@]}"

echo "Backup completed: $backup_file"
