# use debian:bullseye as base image
FROM debian:bullseye

# Install Nginx and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \ 
    openssl 

# Create a directory to store the key and certificate
RUN mkdir /certificate

# Generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /certificate/sarif.key \
    -out /certificate/sarif.crt \
    -subj "/C=MA/ST=CASABLANCA/L=BENAHMED/O=1337/OU=khouribga/CN=localhost"

# Copy the Nginx config
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
