FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/sarif.key \
    -out /etc/nginx/ssl/sarif.crt \
    -subj "/C=MA/ST=benAhemd/L=benAhemd/O=1337/OU=1337/CN=sarif.42.fr"

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

# change the owner of the wordpress directory to nginx
RUN chown -R www-data:www-data /var/www/wordpress

# define the command to run when the container starts in the foreground
CMD ["nginx", "-g", "daemon off;"]
