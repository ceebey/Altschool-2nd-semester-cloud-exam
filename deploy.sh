#!/bin/bash

# Function to configure LAMP stack 
  function configure_lamp {
               # Install Apache
                 apt-get update
                 apt-get install -y apache2

              # Install MySQL and secure installation
              apt-get install -y mysql-server

               #Install PHP (with apache and my SQL)
                sudo apt update
                sudo apt install software-properties-common
                sudo add-apt-repository ppa:ondrej/php -y
                sudo apt update
                sudo apt install php8.1 -y
                sudo apt install php8.1 php8.1-curl libapache2-mod-php8.1 php8.1-bcmath php8.1-zip php8.1-mbstring php8.1-mysql php8.1-gd php8.1-xml php8.1-tokenizer php-common php-json -y
                 
                #deploy the test file inside the default document root of Apache server
                cd /var/www/html
                echo "creating php test file"
                cat <<EOF >> test.php
                <?php
                phpinfo();
                ?>"
EOF
                # You can access the test.php on both nodes by using:
                #Master Node: http://master-node-ip/test.php
                #Slave Node: http://slave-node-ip/test.php

               # Enable Apache mod_rewrite
                # a2enmod rewrite

               # Restart Apache
               systemctl restart apache2
     }


# LAMP Stack Deployment 
 configure_lamp

#Cloning the Laravel repo
#first install git and composer command
sudo apt-get update 
sudo apt-get install git composer -y

#Deploy the laravel inside default document root of apache
# cd /var/www/
sudo touch /var/www/laravel
echo "Cloning the laravel repo"
sudo git clone https://github.com/laravel/laravel /var/www/laravel
# sudo chown -R "$(id -un)" laravel
# cd laravel
apt-get install php-xml php-curl -y
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer install
composer update
mv .env.example .env
php artisan key:generator


#Configure apache for laravel
cd /etc/apache2/sites-available/
sudo touch /etc/apache2/sites-available/laravel.conf
sudo bash -c 'cat <<EOF >> laravel.conf
               <VirtualHost *:80>
                   ServerAdmin admin@example.com
                   ServerName laravel.com
                   DocumentRoot /var/www/laravel/public
     
                   <Directory /var/www/laravel/public>
                       AllowOverride All
                       Require all granted
                       #extra config to disable default index.html
                       DirectoryIndex disabled
                       DirectoryIndex index.php
                   </Directory>
                   ErrorLog ${APACHE_LOG_DIR}/error.log
                   CustomLog ${APACHE_LOG_DIR}/access.log combined
                </VirtualHost>
EOF'

#Activate Apache rewrite module and Laravel virtual host config.
# sudo a2enmod rewrite
sudo a2ensite laravel.conf

echo "Applying changes..."
sudo service apache2 restart

#Adding virtual host to hosts configuration file. change ip address to your machine's ip
# sudo bash -c 'cat <<EOF >> /etc/hosts
#             192.168.56.7  laravel.com
# EOF'

#MySQL configuration
#login to MySQL to create a datebase
# mysql -u root -p
# echo "logging into MySQL"
# CREATE DATABASE Laravel;
# SHOW DATABASES;
# #edit the .env file and define database- By default, Laravel's .env configuration file specifies that Laravel will be interacting with a MySQL database and will access the database at 127.0.0.1.
# cd /var/www/html/laravel
# sudo cat <<EOF >> .env
#                     APP_URL=https://laravel.com
#                     DB_CONNECTION=mysql
#                     DB_HOST=127.0.01
#                     DB_PORT=3306
#                     DB_DATABASE=Laravel
#                     DB_USERNAME=root
#                     DB_PASSWORD=             
# EOF

#create application database table


#to test the app in your browser visit laravel.com