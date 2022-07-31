FROM nginx:stable-alpine

ENV NGINXUSER=laravel
ENV NGINXGROUP=laravel

# Create a folder that our sites will be attached to
RUN mkdir -p /var/www/html/public

# Pull a config file
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# Find and Replace default user www-data and replace with "laravel"
RUN sed -i "s/user www-data-/user ${NGINXUSER}/g" /etc/nginx/nginx.conf

# Add the user
RUN adduser -g ${NGINXGROUP} -s /bin/sh -D ${NGINXUSER}
