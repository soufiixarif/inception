#!bin/bash

sleep 10

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "wordpress already installed"
else
	mkdir -p /var/www/wordpress
	cd /var/www/wordpress
	rm -rf *

    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --allow-root
    mv /var/www/wordpress/wp-config-sample.php  /var/www/wordpress/wp-config.php

    wp config set --allow-root DB_NAME ${MYSQL_DATABASE}
	wp config set --allow-root DB_USER ${MYSQL_USER}
	wp config set --allow-root DB_PASSWORD ${MYSQL_PASSWORD}
	wp config set --allow-root DB_HOST ${DB_HOST}

    wp core install --url=$WEBSITE_DOMAINE_NAME --title=$WEBSITE_TITLE --admin_user=$WEBSITE_ADMIN_NAME --admin_password=$WEBSITE_PASSWORD --admin_email=$WEBSITE_ADMIN_EMAIL --skip-email --allow-root 
	wp user create ${NEW_USER} ${NEW_EMAIL} --user_pass=$NEW_PASS --role=$NEW_ROLE --allow-root
fi
exec "$@"

echo "🔧 Configuring PHP-FPM..."
sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

echo "🚀 Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F