FROM php:fpm-alpine

RUN apk update \
 && apk add nginx \
# forward request and error logs to docker log collector
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
# create a docker-entrypoint.d directory
 && mkdir /docker-entrypoint.d

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-nginx/mainline/alpine/docker-entrypoint.sh /
COPY docker-nginx/mainline/alpine/10-listen-on-ipv6-by-default.sh /docker-entrypoint.d
COPY docker-nginx/mainline/alpine/20-envsubst-on-templates.sh /docker-entrypoint.d
COPY docker-nginx/mainline/alpine/30-tune-worker-processes.sh /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
