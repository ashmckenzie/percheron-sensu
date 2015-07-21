FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/supervisord.d/redis.ini /etc/supervisord.d/redis.ini

RUN apk add --update-cache redis

EXPOSE 6379

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
