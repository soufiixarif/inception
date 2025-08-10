#!/bin/bash

sleep 10
if [ -f /var/www/html/wp-config.php ]; then
    echo "wordpress already installed"
else
	mkdir -p /var/www/html

	cd /var/www/html

	rm -rf *

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  

	chmod +x wp-cli.phar

	mv wp-cli.phar /usr/local/bin/wp

	chmod -R 777 /var/www/html/

	wp core download --allow-root

	mv /var/www/html/wp-config-sample.php  /var/www/html/wp-config.php

	wp config set --allow-root DB_NAME ${MYSQL_DATABASE} 
	wp config set --allow-root DB_USER ${MYSQL_USER}
	wp config set --allow-root DB_PASSWORD ${MYSQL_PASSWORD}
	wp config set --allow-root DB_HOST "mariadb:3306"

	wp core install --url=$WEBSITE_DOMAINE_NAME --title=$WEBSITE_TITLE --admin_user=$WEBSITE_ADMIN_NAME --admin_password=$WEBSITE_PASSWORD --admin_email=$WEBSITE_ADMIN_EMAIL --skip-email --allow-root

	wp user create ${NEW_USER} ${NEW_EMAIL} --user_pass=$NEW_PASS --role=$NEW_ROLE --allow-root

	wp theme install twentytwentyfour --allow-root
	wp theme activate twentytwentyfour --allow-root
fi
echo "wordpress ready to use"
exec "$@"