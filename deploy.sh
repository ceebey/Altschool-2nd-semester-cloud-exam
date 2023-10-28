#!/bin/bash
# clone the repo
echo "cloning the repo"
git clone https://github.com/laravel/laravel
sleep 5

# enter into the repo
echo 
cd laravel

# check directory
echo $(pwd)
sleep 5


# rename .env 
echo "renaming .env"
mv .env.example .env

# install composer dependencies
echo "install php and composer dependencies"
sudo apt-get install php-xml php-curl -y
sudo apt install php-cli php-json php-common curl php-mbstring php-zip unzip zip unzip php-curl php-xml -y
sleep 5

# install composer
echo install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# update the repo
echo "installing repo dependencies"
composer install

# update the repo
composer update

# generate app ket
echo "create appkey"
php artisan key:generate


# disable the default apache page
echo "disable default apache page"
sudo a2dissite 000-default.conf

# navigate to sites-availble
echo "navigating to sites-available"
cd /etc/apache2/sites-available

# check directory
echo $(pwd)

# create your site file
echo "create website conf file"
sudo touch laravel.conf

# update the content
echo "update .conf file"
sudo sed -n 'w laravel.conf' <<EOF
<VirtualHost *:80>
    ServerAdmin chinwoke@gmail.com
    ServerName laravel.local

    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/laravel-error.log
    CustomLog \${APACHE_LOG_DIR}/laravel-access.log combined

    <IfModule mod_dir.c>
        DirectoryIndex index.php
    </IfModule>
</VirtualHost>
EOF


# enable the site
echo "enabling new site"
sudo a2ensite laravel

# create the site directory
echo "creating the site directory"
sudo mkdir -p /var/www/laravel

# copy the content to site directory
cd /home/vagrant
echo $(pwd)
sudo cp -r laravel/. /var/www/laravel/

# go back to the directory
echo "grant permissions"
cd /var/www/laravel
echo $(pwd)

# set permission for the files
sudo chown -R vagrant:www-data /var/www/laravel/
sudo find /var/www/laravel/ -type f -exec chmod 664 {} \;
sudo find /var/www/laravel/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# reload apache
echo "reload apache"
sudo systemctl reload apache2

# done
echo 'webserver is up vist http://192.168.56.7 to view website'
#127.0.0.1