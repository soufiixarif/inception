#!/bin/bash

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

mysqld --user=mysql &
# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  sleep 1
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
  mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL
fi

mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
exec mysqld --user=mysql