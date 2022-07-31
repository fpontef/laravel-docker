FROM nginx:stable-alpine

ENV NGINXUSER=laravel
ENV NGINXGROUP=laravel

ENV CERTIFICATENAME=site.test.crt
ENV CERTIFICATENAMEKEY=site.test.key

# Create a folder that our sites will be attached to
RUN mkdir -p /var/www/html/public

# Pull a config file
ADD nginx/default.prod.conf /etc/nginx/conf.d/default.conf

# Uncomment if you have a certificate and be sure to pass the file name to ENV
# Also uncomment the certificate lines at folder ./nginx/default.prod.conf
#ADD nginx/${CERTIFICATENAME} /etc/nginx/certs/${CERTIFICATENAME}
#ADD nginx/${CERTIFICATENAMEKEY} /etc/nginx/certs/${CERTIFICATENAMEKEY}

# Find and Replace default user www-data and replace with "laravel"
RUN sed -i "s/user www-data-/user ${NGINXUSER}/g" /etc/nginx/nginx.conf

# Add the user
RUN adduser -g ${NGINXGROUP} -s /bin/sh -D ${NGINXUSER}
