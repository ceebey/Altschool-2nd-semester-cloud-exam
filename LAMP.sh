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
                sudo add-ananpt-repository ppa:ondrej/php -y
                sudo apt update
                sudo apt install php8.1 -y
                sudo apt install php8.1 php8.1-curl libapache2-mod-php8.1 php8.1-bcmath php8.1-zip php8.1-mbstring php8.1-mysql php8.1-gd php8.1-xml php8.1-tokenizer php-common php-json -y
                 
               # Restart Apache
               sudo systemctl restart apache2
     }


# LAMP Stack Deployment 
 configure_lamp

