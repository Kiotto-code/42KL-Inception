# #!/bin/bash

# if [ ! -d "/run/mysqld" ]; then
# 	mkdir -p /run/mysqld
# 	chown -R mysql:mysql /run/mysqld
# fi

# echo "Starting MariaDB"
# if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	
# 	echo "Initializing database..."
# 	chown -R mysql:mysql /var/lib/mysql

# 	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

# 	mysql_secure_installation_script="
# 	FLUSH PRIVILEGES;
# 	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# 	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# 	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
# 	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# 	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
# 	FLUSH PRIVILEGES;
# 	"

# 	mysqld --user=mysql --bootstrap <<< $mysql_secure_installation_script
# fi

# # allow remote connections
# sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
# # [mysqld]
# # user = root
# # port = 3306
# # datadir = /var/lib/mysql
# # socket = /var/run/mysqld/mysqld.sock
# # skip-networking = false
# # bind-address = 0.0.0.0

# exec "$@"

#!/bin/bash

service mysql start

mysql -e "CREATE DATABASE IF NOT EXISTS ${database_name};"
mysql -e "CREATE USER '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';"
mysql -u${mysql_root_user} -p${mysql_root_password} -e "ALTER USER '${mysql_root_user}'@'localhost' IDENTIFIED BY '${mysql_root_password}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown

exec "$@"