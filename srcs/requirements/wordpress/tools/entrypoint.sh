#!/bin/bash

mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

if [ ! -e "./wp-config.php" ]; then

	wp core download --allow-root

	wp config create --dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=$MYSQL_HOSTNAME \
	--allow-root

	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root

	wp core install --url=$DOMAIN_NAME \
		--title="Inception" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root

	wp plugin install redis-cache --allow-root
	wp plugin update --all --allow-root
	wp plugin activate redis-cache --allow-root
	wp redis enable --allow-root
	wp cache flush --allow-root

	wp user create $WP_USER $WP_USER_EMAIL \
		--role=subscriber \
		--user_pass=$WP_USER_PASSWORD \
		--first_name=$WP_USER_FNAME \
		--last_name=$WP_USER_LNAME \
		--user_url=$WP_USER_URL \
		--allow-root

	chown -R www-data:www-data .
	chmod -R 775 .
fi

exec "$@"