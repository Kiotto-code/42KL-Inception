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

RUN apt-get update -y && \
    apt-get install -y mariadb-server

COPY ./tools/mdb_entrypoint.sh /tmp/mdb_entrypoint.sh

RUN  chmod +x /tmp/mdb_entrypoint.sh

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

ENTRYPOINT ["bash", "/tmp/mdb_entrypoint.sh"]

CMD ["mysqld_safe"]