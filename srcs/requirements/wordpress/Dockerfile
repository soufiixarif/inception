# Base image based on Debian Bullseye
FROM debian:bullseye

# Install base packages:
# - mariadb-client: optional; allows container to connect directly to MariaDB from CLI
RUN apt-get update && apt-get install -y \
    curl \
    php \
    php-fpm \
    php-mysql \
    mariadb-client

# Create the web root and ensure it's owned by www-data (used by nginx/php-fpm)
RUN mkdir -p /var/www/html/ && \
    chown -R www-data /var/www/html

# Create the /run/php directory (needed for php-fpm socket or PID) and own it
RUN mkdir -p /run/php/ && chown -R www-data /run/php/

# Set the working directory for next instructions and for runtime
WORKDIR /var/www/html

# Modify PHP-FPM pool to listen on 0.0.0.0:9000 instead of default Unix socket
# This is necessary for container interconnection (e.g. connecting from nginx)
# Debian Bullseye default is PHP 7.4.
RUN sed -i "s|^listen = .*|listen = 0.0.0.0:9000|" /etc/php/7.4/fpm/pool.d/www.conf

# Install WP-CLI for managing WordPress installation
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy initialization script into the container
COPY ./tools/config.sh /config.sh

# Make the config script executable
RUN chmod +x /config.sh

# Start script as container entrypoint (will typically run WordPress setup + php-fpm)
ENTRYPOINT [ "bash", "/config.sh" ]

CMD ["php-fpm7.4", "-F"]