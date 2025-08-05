FROM debian:bullseye

RUN apt update && apt install -y curl php php-fpm php-mysql

COPY . .

ENTRYPOINT ["bash", "tools/config.sh"]
