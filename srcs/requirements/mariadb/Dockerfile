# FROM debian:bullseye

# RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

# RUN apt-get -y update
# RUN apt-get -y install mariadb-server \
# 	&& rm -rf /var/lib/apt/lists/*

# COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
# RUN chmod +x /tmp/entrypoint.sh

# EXPOSE 3306

# ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD ["mysqld", "--user=mysql", "--console"]

FROM debian:bullseye

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists*

# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mdb_entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mdb_entrypoint.sh

RUN mkdir -p /var/run/mysqld/ \
	&& touch /var/run/mysqld/mysqld.pid \
	&& touch /var/run/mysqld/mysqld.sock \
	&& chown mysql:mysql -R /var/run/mysqld \
	&& chmod 755 /var/run/mysqld \
	&& chmod 777 /var/run/mysqld/mysqld.sock \
	&& chmod 660 /var/run/mysqld/mysqld.pid

RUN chown -R mysql:mysql /var/lib/mysql \
	&& chmod -R 777 /var/lib/mysql/ \
	&& chmod -R 777 /var/lib/mysql/*

RUN mkdir -p /run/mysqld \
	&& chown mysql:root /run/mysqld

EXPOSE 3306

ENTRYPOINT ["mdb_entrypoint.sh"]
