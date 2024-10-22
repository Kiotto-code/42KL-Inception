#!/bin/bash

mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid


if [ ! -e "./wp-config.php" ]; then

	wp core download --allow-root

	wp config create --dbname=$database_name \
	--dbuser=$mysql_user \
	--dbpass=$mysql_password \
	--dbhost=$mysql_host \
	--allow-root

	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root	

	wp core install --url=$domain_name \
		--title="inception" \
		--admin_user=$wordpress_admin \
		--admin_password=$wordpress_admin_password \
		--admin_email=$wordpress_admin_email \
		--allow-root

	wp plugin install redis-cache --allow-root
	wp plugin update --all --allow-root
	wp plugin activate redis-cache --allow-root
	wp redis enable --allow-root
	wp cache flush --allow-root

	wp user create $login $wp_user_email \
		--role=subscriber \
		--user_pass=$wp_user_pwd \
		--user_url=$wp_user_url \
		--allow-root
		# --first_name=$WP_USER_FNAME \
		# --last_name=$WP_USER_LNAME \

	 #   wp config  set WP_DEBUG true  --allow-root

    # wp config set FORCE_SSL_ADMIN 'false' --allow-root

    # wp config  set WP_REDIS_HOST $redis_host --allow-root

    # wp config set WP_REDIS_PORT $redis_port --allow-root

    # wp config  set WP_CACHE 'true' --allow-root

    # wp plugin install redis-cache --allow-root

    # wp plugin activate redis-cache --allow-root

    # wp redis enable --allow-root

    # chmod 777 /var/www/html/wp-content

    # # install theme

    # wp theme install twentyfifteen

    # wp theme activate twentyfifteen

    # wp theme update twentyfifteen

	chown -R www-data:www-data .
	chmod -R 775 .
fi

exec "$@"