#!/bin/bash

# Start MariaDB service
service mariadb start

# Wait until MariaDB is ready
until mysqladmin ping -u root --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 1
done

# Create database and user if they don't exist
echo "Creating database and user..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary service
service mariadb stop

# Start MariaDB in safe mode with config
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'