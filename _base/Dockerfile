FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

RUN apk add --update-cache build-base libffi-dev ruby@testing ruby-dev@testing perl

RUN echo 'gem: --no-document' > /etc/gemrc
RUN gem install sensu-plugin erubis rest-client specific_install
RUN gem specific_install https://github.com/ashmckenzie/sensu.git

RUN mkdir -p /etc/sensu/conf.d /etc/sensu/ssl /etc/sensu/plugins /etc/sensu/handlers /var/log/sensu

RUN cp /data/ssl/*.pem /etc/sensu/ssl/

WORKDIR /etc/sensu/handlers
ADD ./config/sensu/handlers/* ./

WORKDIR /etc/sensu/conf.d
ADD ./config/sensu/conf.d/* ./
RUN sed -i 's%<RABBITMQ_HOST>%{{ secrets.rabbitmq.host }}%' rabbitmq.json
RUN sed -i 's%<RABBITMQ_PORT>%{{ secrets.rabbitmq.port }}%' rabbitmq.json
RUN sed -i 's%<RABBITMQ_VHOST>%{{ secrets.rabbitmq.vhost }}%' rabbitmq.json
RUN sed -i 's%<RABBITMQ_USER>%{{ secrets.rabbitmq.user }}%' rabbitmq.json
RUN sed -i 's%<RABBITMQ_PASSWORD>%{{ secrets.rabbitmq.password }}%' rabbitmq.json
RUN sed -i 's%<SLACK_HILANDER_WEBHOOK_URL>%{{ secrets.slack.hilander_webhook_url }}%' plugin-slack_hilander.json
RUN sed -i 's%<VICTOROPS_HILANDER_API_URL>%{{ secrets.victorops.hilander_api_url }}%' plugin-victorops_hilander.json
RUN sed -i 's%<PUSHBULLET_ASH_API_KEY>%{{ secrets.pushbullet.ash.api_key }}%' plugin-pushbullet_ash.json
RUN sed -i 's%<PUSHBULLET_ASH_DEVICE_ID>%{{ secrets.pushbullet.ash.device_id }}%' plugin-pushbullet_ash.json
RUN sed -i 's%<PUSHBULLET_CHANNEL_TAG>%{{ secrets.pushbullet.channel_tag }}%' plugin-pushbullet_ash.json

WORKDIR /etc/sensu/plugins
ADD ./config/sensu/plugins/* ./

ENV SENSU_URL http://{{ userdata.sensu.host }}:{{ userdata.sensu.port }}
ENV SENSU_HOST {{ userdata.sensu.host }}
ENV SENSU_PORT {{ userdata.sensu.port }}
ENV RABBITMQ_HOST {{ userdata.rabbitmq.host }}
ENV RABBITMQ_PORT {{ userdata.rabbitmq.port }}
ENV RABBITMQ_VHOST {{ userdata.rabbitmq.vhost }}
ENV RABBITMQ_USER {{ secrets.rabbitmq.user }}
ENV RABBITMQ_PASSWORD {{ secrets.rabbitmq.password }}

RUN chmod 755 /etc/sensu/plugins/*.rb
