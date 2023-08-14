#!/bin/bash

# Update package lists
sudo apt update

# Install required packages
sudo apt install -y apache2 mariadb-server libapache2-mod-php7.4 php7.4-gd php7.4-json php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl php7.4-imagick php7.4-xml php7.4-zip

# Secure MariaDB installation
sudo mysql_secure_installation

# Create a Nextcloud database and user
read -p "Enter a new database name for Nextcloud: " dbname
read -p "Enter a new database user for Nextcloud: " dbuser
read -sp "Enter a password for the database user: " dbpassword
echo
sudo mysql -e "CREATE DATABASE $dbname; GRANT ALL ON $dbname.* TO '$dbuser'@'localhost' IDENTIFIED BY '$dbpassword'; FLUSH PRIVILEGES;"

# Download and extract Nextcloud
wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xjf latest.tar.bz2 -C /var/www/
sudo chown -R www-data:www-data /var/www/nextcloud

# Create an Apache virtual host for Nextcloud
sudo tee /etc/apache2/sites-available/nextcloud.conf > /dev/null << EOF
<VirtualHost *:80>
    ServerName your_domain_or_ip

    DocumentRoot /var/www/nextcloud

    <Directory /var/www/nextcloud>
        Require all granted
        AllowOverride All
        Options FollowSymlinks MultiViews

        <IfModule mod_dav.c>
            Dav off
        </IfModule>
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable the virtual host and required Apache modules
sudo a2ensite nextcloud
sudo a2enmod rewrite headers env dir mime ssl

# Restart Apache
sudo systemctl restart apache2

# Open necessary ports in the firewall
sudo ufw allow 80,443/tcp

echo "Nextcloud installation, configuration, and setup completed successfully."
