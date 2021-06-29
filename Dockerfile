FROM php:fpm-alpine

RUN apk update \
 && apk add nginx \
# forward request and error logs to docker log collector
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
# create a docker-entrypoint.d directory
 && mkdir /docker-entrypoint.d

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
