#!/bin/bash

# sed -i "s/NGINX_PORT/$NGINX_PORT/g" /etc/nginx/conf.d/default.conf
sed "s/localhost/$DOMAIN_NAME/g" /etc/nginx/sites-available/nginx.conf

exec "$@" # exec nginx -g 'daemon off;' (daemon off is the default command in the nginx image)