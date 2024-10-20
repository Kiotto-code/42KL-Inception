# #!/bin/bash

# mkdir -p /run/php/
# touch /run/php/php7.4-fpm.pid

# if [ ! -e "./wp-config.php" ]; then

# 	wp core download --allow-root

# 	wp config create --dbname=$MYSQL_DATABASE \
# 	--dbuser=$MYSQL_USER \
# 	--dbpass=$MYSQL_PASSWORD \
# 	--dbhost=$MYSQL_HOSTNAME \
# 	--allow-root

# 	wp config set WP_REDIS_HOST redis --allow-root
# 	wp config set WP_REDIS_PORT 6379 --allow-root

# 	wp core install --url=$DOMAIN_NAME \
# 		--title="Inception" \
# 		--admin_user=$WP_ADMIN_USER \
# 		--admin_password=$WP_ADMIN_PASSWORD \
# 		--admin_email=$WP_ADMIN_EMAIL \
# 		--allow-root

# 	wp plugin install redis-cache --allow-root
# 	wp plugin update --all --allow-root
# 	wp plugin activate redis-cache --allow-root
# 	wp redis enable --allow-root
# 	wp cache flush --allow-root

# 	wp user create $WP_USER $WP_USER_EMAIL \
# 		--role=subscriber \
# 		--user_pass=$WP_USER_PASSWORD \
# 		--first_name=$WP_USER_FNAME \
# 		--last_name=$WP_USER_LNAME \
# 		--user_url=$WP_USER_URL \
# 		--allow-root

# 	chown -R www-data:www-data .
# 	chmod -R 775 .
# fi

# exec "$@"

#!bin/bash

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$database_name --dbuser=$mysql_user \
        --dbpass=$mysql_password --dbhost=$mysql_host --allow-root  --skip-check

    wp core install --url=$domain_name --title=$brand --admin_user=$wordpress_admin \
        --admin_password=$wordpress_admin_password --admin_email=$wordpress_admin_email \
        --allow-root

    wp user create $login $wp_user_email --role=author --user_pass=$wp_user_pwd --allow-root
    wp config set FORCE_SSL_ADMIN 'false' --allow-root
    wp config  set WP_REDIS_HOST $redis_host --allow-root
    wp config set WP_REDIS_PORT $redis_port --allow-root
    wp config  set WP_CACHE 'true' --allow-root
    wp plugin install redis-cache --allow-root
    wp plugin activate redis-cache --allow-root
    wp redis enable --allow-root
    chmod 777 /var/www/html/wp-content

    # install theme

    wp theme install twentyfifteen

    wp theme activate twentyfifteen

    wp theme update twentyfifteen
fi


/usr/sbin/php-fpm7.3 -F