FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y install nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

# COPY conf/nginx.conf /etc/nginx/sites-available/nginx.conf
# RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf
COPY conf/nginx.conf /etc/nginx/conf.d/


RUN mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/yichan.42.fr.key -out /etc/nginx/ssl/yichan.42.fr.crt \
	-subj "/C=MY/ST=Selangor/L=Kuala Lumpur/O=42KL/OU=yichan/CN=yichan.42.fr"

# RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# COPY ssl /etc/ssl
RUN chmod 644 /etc/ssl/*

COPY conf/404.html /usr/share/nginx/html/404.html

COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]