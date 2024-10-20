FROM debian:buster

RUN apt update; \
    apt install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/yichan.key \
    -out /etc/ssl/certs/yichan.crt \
    -subj="/C=MY/ST=Selangor/L=Kuala Lumpur/O=42KL/OU=yichan/CN=yichan.42.fr"

COPY ./tools/certs.sh /tmp/certs.sh

RUN chmod +x /tmp/certs.sh

COPY ./conf/default /etc/nginx/sites-available/default


ENTRYPOINT ["/tmp/certs.sh"]
# CMD ["nginx", "-g", "daemon off;"]
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]