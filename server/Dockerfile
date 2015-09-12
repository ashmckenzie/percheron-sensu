FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

RUN mkdir -p /etc/sensu/checks

WORKDIR /etc/sensu/conf.d
ADD ./config/sensu/conf.d/* ./

WORKDIR /etc/supervisor.d/
ADD ./config/supervisor.d/* ./

WORKDIR /etc/sensu/checks
ADD ./config/sensu/checks/* ./

RUN sed -i 's%<IMAGE_PROXY_URL>%{{ secrets.image_proxy.url }}%' *.json

WORKDIR /etc/sensu

ADD ./config/start /start
RUN chmod 755 /start

EXPOSE 4567

CMD [ "/start" ]
