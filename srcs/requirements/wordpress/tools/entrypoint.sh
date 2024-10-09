#!/bin/bash

touch /run/php/php7.3-fpm.pid;

if [ -d /var/www/html/wp-config.php ]; then
	echo "Wordpress wp-config.php exists"
else
	#MANDATORY
	echo "Wordpress setting up"
	mkdir -p /var/www/html
	# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	# chmod +x wp-cli.phar; 
	# mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;
	wp core download --allow-root;
	
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root 
	wp core install --allow-root --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --display_name=$WP_USER --role=$WP_USER_ROLE --allow-root
	
	wp theme install bizboost --activate --allow-root  

	#BONUS
	wp config set WP_REDIS_HOST redis --add --allow-root
    wp config set WP_REDIS_PORT 6379 --add --allow-root  
    wp config set WP_CACHE true --add --allow-root 
	wp plugin install redis-cache --activate --allow-root  
    wp plugin update --all --allow-root  
    wp redis enable --allow-root

	wp CREATE USER $MYSQL_USER@'%' IDENTIFIED BY $MYSQL_PASSWORD;
	echo "Redis setup success"
fi

exec "$@"