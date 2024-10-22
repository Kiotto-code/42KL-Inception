#!/bin/bash

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

echo "Starting MariaDB..."

if [ ! -d "/var/lib/mysql/${database_name}" ]; then
	
	echo "Initializing database..."
	chown -R mysql:mysql /var/lib/mysql

	# init database
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	mysql_secure_installation_script="
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysql_root_password}';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	CREATE DATABASE IF NOT EXISTS ${database_name};
	CREATE USER IF NOT EXISTS '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';
	GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';
	FLUSH PRIVILEGES;
	"

	mysqld --user=mysql --bootstrap <<< $mysql_secure_installation_script
    mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown
fi

# allow remote connections
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

exec "$@"