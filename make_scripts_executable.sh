#!/bin/bash

# Check if the folder path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

folder_path="$1"

# Check if the specified folder exists
if [ ! -d "$folder_path" ]; then
    echo "Error: Folder '$folder_path' does not exist."
    exit 1
fi

# Make all scripts in the folder executable
find "$folder_path" -type f -name "*.sh" -exec chmod +x {} \;

echo "All scripts in '$folder_path' are now executable."

# Save this script to a file (e.g., make_scripts_executable.sh), make it executable (chmod +x make_scripts_executable.sh), and then run it with the path to the folder containing your scripts:

# ./make_scripts_executable.sh /path/to/your/scripts/folder
# This script will find all files with a .sh extension in the specified folder and make them executable using chmod +x. Make sure to replace /path/to/your/scripts/folder with the actual path to your scripts folder.