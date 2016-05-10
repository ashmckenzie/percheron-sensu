FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

RUN apk add --update-cache redis

ADD ./config/supervisor.d/redis.ini /etc/supervisor.d/redis.ini
ADD ./config/redis.conf /etc/redis.conf

EXPOSE 6379

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
