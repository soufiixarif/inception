#!/bin/bash

# Start MariaDB service
service mariadb start

# Create database and user if they don't exist
echo "Creating database and user..."
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary service
service mariadb stop

# Start MariaDB in safe mode with config
mysqld