FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

RUN mkdir -p /etc/sensu/ssl /etc/sensu/plugins /etc/sensu/handlers /var/log/sensu

ADD ./config/sensu/conf.d/config.json /etc/sensu/config.json
ADD ./config/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d/rabbitmq.json
ADD ./config/sensu/conf.d/plugin-slack_hilander.json /etc/sensu/conf.d/plugin-slack_hilander.json
ADD ./config/sensu/handlers/slack_hilander.json /etc/sensu/handlers/slack_hilander.json

ADD ./config/supervisord.d/sensu_client.ini /etc/supervisord.d/sensu_client.ini

RUN cp /data/ssl/*.pem /etc/sensu/ssl/
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-slack/master/bin/handler-slack.rb -O slack.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-http/master/bin/check-http-json.rb
RUN chmod 755 /etc/sensu/plugins/*.rb

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
