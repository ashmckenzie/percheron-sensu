FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

RUN mkdir -p /etc/sensu/checks

WORKDIR /etc/sensu/conf.d
ADD ./config/sensu/conf.d/* ./

WORKDIR /etc/supervisor.d/
ADD ./config/supervisor.d/* ./

WORKDIR /etc/sensu/checks
ADD ./config/sensu/checks/* ./

RUN sed -i 's%<IMAGER_SCALER_URL>%{{ secrets.image_scaler.url }}%' *.json
RUN sed -i 's%<IMAGER_SCALER_API_KEY>%{{ secrets.image_scaler.api_key }}%' *.json

WORKDIR /etc/sensu

ADD ./config/start /start
RUN chmod 755 /start

EXPOSE 4567

CMD [ "/start" ]
