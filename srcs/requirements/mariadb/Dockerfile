FROM debian:bullseye

RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

RUN apt-get -y update
RUN apt-get -y install mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/entrypoint.sh"]
CMD ["mysqld", "--user=mysql", "--console"]