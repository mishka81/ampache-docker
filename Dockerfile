FROM alpine:3.8
LABEL author=mickael@humbkr.com

ENV UID=1000
ENV GID=1000

ENV PHP_FPM_USER="nginx" 
ENV PHP_FPM_GROUP="nginx" 
ENV PHP_FPM_LISTEN_MODE="0660" 
ENV PHP_MEMORY_LIMIT="64M" 
ENV PHP_MAX_UPLOAD="50M" 
ENV PHP_MAX_FILE_UPLOAD="200" 
ENV PHP_MAX_POST="100M" 
ENV PHP_DISPLAY_ERRORS="On" 
ENV PHP_DISPLAY_STARTUP_ERRORS="On" 
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR" 
ENV PHP_CGI_FIX_PATHINFO=0

ENV AMPACHE_VERSION=3.9.0
ENV NGINX_PORT=80

ENV DB_DATA_PATH="/var/lib/mysql"
ENV DB_ROOT_PASS="ampache"
ENV DB_USER="ampache"
ENV DB_PASS="ampache"
ENV MAX_ALLOWED_PACKET="200M"

# Install alpine pkg
RUN apk add php7 php7-pdo php7-pdo_mysql php7-session php7-json php7-simplexml php7-fpm \ 
php7-phar php7-iconv php7-gd php7-mbstring php7-curl php7-tokenizer nginx mariadb mariadb-client git gettext ffmpeg shadow

# Setup PHP
ADD install_php.sh /install_php.sh
RUN chmod 755 /install_php.sh
RUN php -r "readfile('https://getcomposer.org/installer');" | php && mv composer.phar /usr/local/bin/composer

# Setup ampache 
RUN rm /etc/nginx/conf.d/default.conf
ADD nginx.conf.tpl /tmp/nginx.conf.tpl
RUN wget -qO- https://github.com/ampache/ampache/archive/${AMPACHE_VERSION}.tar.gz | tar xvz -C /tmp
RUN mv /tmp/ampache*/* /var/www/
RUN cd /var/www && composer install --prefer-source --no-interaction
ADD info.php /var/www/info.php

# Setup MySQL install script
ADD install_mysql.sh /install_mysql.sh
RUN chmod 755 /install_mysql.sh

# Setup container's entrypoint
ADD run.sh /run.sh
RUN chmod 755 /run.sh

VOLUME  ["/etc/mysql", "/var/lib/mysql"]
# Ampache library
VOLUME ["/media"]
VOLUME ["/var/www/config"]
VOLUME ["/var/www/themes"]

EXPOSE 80

CMD ["/run.sh"]