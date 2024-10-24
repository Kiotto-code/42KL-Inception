FROM debian:bullseye

# COPY ./conf/wordpress_pool.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	php php-fpm php-mysql mariadb-server curl \
	vim \
	; \
	rm -rf /var/lib/apt/lists/*
	# vim && \
    # sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# RUN apt-get install -y 

RUN mkdir -p /run/php

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --allow-root

COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["bash", "script.sh"]
