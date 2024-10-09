FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y install php7.4 php-fpm php-mysqli wget curl \
	&& rm -rf /var/lib/apt/lists/*

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh
EXPOSE 9000
WORKDIR /var/www/html

ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
