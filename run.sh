#!/bin/sh

# Launch mysql in background
mysqld_safe &
# Launch PHP-FPM in background
php-fpm7
# Launch nginx in foreground
nginx -g 'pid /tmp/nginx.pid; daemon off;'
