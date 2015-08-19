FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/sensu/conf.d/config.json /etc/sensu/config.json
ADD ./config/sensu/conf.d/api.json /etc/sensu/conf.d/api.json
ADD ./config/sensu/conf.d/redis.json /etc/sensu/conf.d/redis.json

ADD ./config/sensu/checks/hilander.json /etc/sensu/checks/hilander.json

ADD ./config/supervisord.d/sensu_server.ini /etc/supervisord.d/sensu_server.ini
ADD ./config/supervisord.d/sensu_api.ini /etc/supervisord.d/sensu_api.ini

RUN sed -i 's%<RABBITMQ_USER>%{{ secrets.rabbitmq.user }}%' /etc/sensu/checks/*.json
RUN sed -i 's%<RABBITMQ_PASSWORD>%{{ secrets.rabbitmq.password }}%' /etc/sensu/checks/*.json

ADD ./config/start /start
RUN chmod 755 /start

EXPOSE 4567

CMD [ "/start" ]
