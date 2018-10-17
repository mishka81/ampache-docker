#!/bin/sh

# Update PHP config
/install_php.sh

# Fix permissions for music volume
# Specify owner at runtime with : docker run -e "UID=<UID>" -e "GID=<GID>" 
# Default user & group id : 1000
usermod -u ${UID} ${PHP_FPM_USER}
groupmod -g ${GID} ${PHP_FPM_USER}
chown -R ${PHP_FPM_USER}:${PHP_FPM_USER} /var/www &

# Launch mysql in background
mysqld_safe &
# Launch PHP-FPM in background
php-fpm7
# Launch nginx in foreground
nginx -g 'pid /tmp/nginx.pid; daemon off;'
