FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/sensu/conf.d/config.json /etc/sensu/
ADD ./config/supervisor.d/sensu_client.ini /etc/supervisor.d/

ADD ./config/start /start
RUN chmod 755 /start

CMD [ "/start" ]
