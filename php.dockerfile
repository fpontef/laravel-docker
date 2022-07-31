FROM php:8-fpm-alpine

ENV PHPGROUP=laravel
ENV PHPUSER=laravel

RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

# The php conf file is big and we can just replace the text using sed
RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html/public

# This is an easier way to install extensions needed by laravel on php-fpm
RUN docker-php-ext-install pdo pdo_mysql

# -R allow php to run as root
# This is needed to avoid mismatch files user/groups on Linux/Windows
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
