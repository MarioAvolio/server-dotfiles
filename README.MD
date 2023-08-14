# Server Dotfiles and Automation Scripts for Debian

This repository contains a collection of dotfiles and automation scripts tailored for setting up and configuring a server running Debian. These dotfiles and scripts are designed to help you streamline your server setup and maintenance process on Debian-based systems.

## Dotfiles

- `.bashrc`: Customizes the behavior and appearance of the Bash shell.
- `.vimrc`: Configures Vim text editor settings.
- `.tmux.conf`: Customizes settings for the Tmux terminal multiplexer.

## Scripts

1. [**Install and Configure i3wm with LightDM**](./install_i3_lightdm_autologin.sh):
   This script installs the i3 window manager, configures LightDM for autologin, and sets up essential packages for a minimal desktop environment on Debian.

2. [**Install and Configure UFW Firewall**](./install_ufw_with_services.sh):
   This script installs the UFW (Uncomplicated Firewall) and configures it to allow essential services like SSH, FTP, HTTP, and HTTPS on Debian.

3. [**Create System Backup**](./create_system_backup.sh):
   This script creates a backup archive of essential system directories using the tar command on Debian.

4. [**Install Server Packages**](./install_server_packages.sh):
   This script installs essential server packages such as SSH, UFW, fail2ban, wget, curl, git, nano, and more on Debian.

## Usage

1. Clone this repository to your Debian server:

   ```bash
   git clone https://github.com/MarioAvolio/server-dotfiles.git
   cd server-dotfiles
   ```

2. Make the desired script(s) executable:

   ```bash
   chmod +x script-name.sh
   ```

3. Run the script(s) you need:

   ```bash
   ./script-name.sh
   ```

Follow any on-screen prompts and instructions provided by the script.

Please review the script and its documentation before running it to understand its functionality and potential impact.

## Note

- These dotfiles and scripts are provided as-is and are intended for use on Debian-based systems.
- Review and understand each script before running it on your server.
- Always back up your data before making significant changes to your system.

## License

This project is licensed under the [MIT License](./LICENSE).
