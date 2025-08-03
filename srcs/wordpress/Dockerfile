FROM debian:bullseye

RUN apt update && apt install -y curl php php-fpm php-mysql

COPY ./config.sh /

RUN chmod +x config.sh

ENTRYPOINT ["bash", "/config.sh"]
