# Use Debian stable as base image
FROM debian:bullseye
# install necessary packages
RUN apt-get update && apt-get install -y mariadb-server
# copy script to the container
COPY ./tools/script.sh /script.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
# give execution permission to the script
RUN chmod +x /script.sh
#run the script
CMD ["./script.sh"]