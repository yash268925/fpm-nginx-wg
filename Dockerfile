FROM php:fpm-alpine

WORKDIR /var/www

RUN apk update \
 && apk add nginx imagemagick ffmpeg \
 && pear install Mail \
# forward request and error logs to docker log collector
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
# create a docker-entrypoint.d directory
 && mkdir /docker-entrypoint.d \
# change docroot directory name and clean
 && mv /var/www/html /var/www/pub \
 && rm -rf /var/www/localhost

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
