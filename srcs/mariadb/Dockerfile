FROM debian:bullseye

RUN apt-get update && apt install  -y mariadb-server

COPY ./script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["./script.sh"]
