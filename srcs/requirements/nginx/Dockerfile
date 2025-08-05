FROM debian:bullseye

RUN apt update && apt install -y nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
