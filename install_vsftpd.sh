#!/bin/bash

# Update package lists
sudo apt update

# Install vsftpd
sudo apt install -y vsftpd

# Configure vsftpd
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.backup

cat <<EOT | sudo tee /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
force_dot_files=YES
pasv_min_port=40000
pasv_max_port=40100
EOT

# Restart vsftpd
sudo systemctl restart vsftpd

# Configure Firewall (UFW)
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 40000:40100/tcp
sudo ufw reload

echo "vsftpd installation and configuration completed successfully."
