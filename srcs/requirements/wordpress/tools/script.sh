#!bin/bash

# wait for mysql to start
sleep 10

mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

# Install Wordpress

if [ ! -f /var/www/html/wp-config.php ]; then

    wp config create --dbname=$database_name --dbuser=$mysql_user \
        --dbpass=$mysql_password --dbhost=$mysql_host --allow-root  --skip-check
	# wp user create $domain_name $wordpress_admin_email --role=administrator --user_pass=$wordpress_admin_password --allow-root

    wp core install --url=$domain_name --title=$site_title --admin_user=$wordpress_admin \
        --admin_password=$wordpress_admin_password --admin_email=$wordpress_admin_email \
        --allow-root

    wp user create $login $wp_user_email --role=author --user_pass=$wp_user_pwd --allow-root

 #   wp config  set WP_DEBUG true  --allow-root

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

sed -i 's|/run/php/php7.4-fpm.sock|9000|' /etc/php/7.4/fpm/pool.d/www.conf
cp ./conf/wordpress_pool.conf /etc/php/7.4/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.4 -F