#!/bin/sh

# Update MySQL config
/install_mysql.sh

# Update PHP config
/install_php.sh

# Update Nginx config
envsubst '${NGINX_PORT}' < /tmp/nginx.conf.tpl > /etc/nginx/conf.d/ampache.conf

# Fix permissions for access to music volume by PHP processes
# Specify owner at runtime with : docker run -e "UID=<UID>" -e "GID=<GID>" 
# Default user & group id : 1000
usermod -u ${UID} ${PHP_FPM_USER}
groupmod -g ${GID} ${PHP_FPM_USER}
# ampache config files must be writable by php process owner
chown -R ${PHP_FPM_USER}:${PHP_FPM_USER} /var/www/config

# Launch mysql in background
mysqld_safe &
# Launch PHP-FPM in background
php-fpm7
# Launch Nginx in foreground
nginx -g 'pid /tmp/nginx.pid; daemon off;'
