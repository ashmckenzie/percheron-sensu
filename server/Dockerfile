FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/sensu/conf.d/config.json /etc/sensu/config.json
ADD ./config/sensu/conf.d/api.json /etc/sensu/conf.d/api.json
ADD ./config/sensu/conf.d/redis.json /etc/sensu/conf.d/redis.json

ADD ./config/sensu/checks/hilander.json /etc/sensu/checks/hilander.json

ADD ./config/supervisord.d/sensu_server.ini /etc/supervisord.d/sensu_server.ini
ADD ./config/supervisord.d/sensu_api.ini /etc/supervisord.d/sensu_api.ini

WORKDIR /etc/sensu/checks

RUN sed -i 's%<IMAGER_SCALER_API_KEY>%{{ secrets.image_scaler.api_key }}%' *.json
RUN sed -i 's%<SENSU_HOST>%{{ userdata.sensu.host }}%' *.json
RUN sed -i 's%<SENSU_PORT>%{{ userdata.sensu.port }}%' *.json
RUN sed -i 's%<RABBITMQ_USER>%{{ secrets.rabbitmq.user }}%' *.json
RUN sed -i 's%<RABBITMQ_PASSWORD>%{{ secrets.rabbitmq.password }}%' *.json

WORKDIR /etc/sensu

ADD ./config/start /start
RUN chmod 755 /start

EXPOSE 4567

CMD [ "/start" ]
