#!/bin/bash

# Save the script to a file, for example, configure_ftp_tls.sh, make it executable using chmod +x configure_ftp_tls.sh, and then run it with elevated privileges using sudo ./configure_ftp_tls.sh.

# This script will install vsftpd, configure it with the provided vsftpd.conf settings and FTP over TLS, and configure the firewall rules accordingly.

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
allow_writeable_chroot=YES
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

# Generate SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem

# Set permissions for the SSL certificate
sudo chmod 600 /etc/ssl/private/vsftpd.pem

# Configure vsftpd to use SSL
sudo sed -i 's/ssl=NO/ssl=YES/' /etc/vsftpd.conf
sudo sed -i 's/rsa_cert_file/#rsa_cert_file/' /etc/vsftpd.conf
sudo sed -i 's/rsa_private_key/#rsa_private_key/' /etc/vsftpd.conf
echo "rsa_cert_file=/etc/ssl/private/vsftpd.pem" | sudo tee -a /etc/vsftpd.conf
echo "rsa_private_key_file=/etc/ssl/private/vsftpd.pem" | sudo tee -a /etc/vsftpd.conf

# Restart vsftpd service
sudo systemctl restart vsftpd

# Configure Firewall (UFW)
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 40000:40100/tcp
sudo ufw reload

echo "vsftpd installation and configuration with FTP over TLS completed successfully."
