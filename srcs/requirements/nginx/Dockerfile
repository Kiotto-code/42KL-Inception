FROM debian:bullseye

RUN apt update -y; \
    apt install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/yichan.key \
    -out /etc/ssl/certs/yichan.crt \
    -subj="/C=MY/ST=Selangor/L=Kuala Lumpur/O=42KL/OU=yichan/CN=yichan.42.fr"

COPY ./tools/ngx_entrypoint.sh /tmp/certs.sh

# COPY conf/404.html /usr/share/nginx/html/404.html

RUN chmod +x /tmp/certs.sh

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

ENTRYPOINT ["/tmp/certs.sh"]
