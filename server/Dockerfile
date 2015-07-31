FROM sensu_base:1.0.0
MAINTAINER ash@the-rebellion.net

RUN mkdir -p /etc/sensu/ssl /etc/sensu/plugins /etc/sensu/checks /etc/sensu/handlers /var/log/sensu

ADD ./config/sensu/conf.d/config.json /etc/sensu/config.json
ADD ./config/sensu/conf.d/api.json /etc/sensu/conf.d/api.json
ADD ./config/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d/rabbitmq.json
ADD ./config/sensu/conf.d/redis.json /etc/sensu/conf.d/redis.json

ADD ./config/sensu/conf.d/plugin-slack_hilander.json /etc/sensu/conf.d/plugin-slack_hilander.json
ADD ./config/sensu/conf.d/plugin-victorops_hilander.json /etc/sensu/conf.d/plugin-victorops_hilander.json

ADD ./config/sensu/handlers/slack_hilander.json /etc/sensu/checks/slack_hilander.json
ADD ./config/sensu/handlers/victorops_hilander.json /etc/sensu/checks/victorops_hilander.json

ADD ./config/sensu/checks/api_hilander_http_json.json /etc/sensu/checks/api_hilander_http_json.json
ADD ./config/sensu/checks/hilander_http_json.json /etc/sensu/checks/hilander_http_json.json

ADD ./config/supervisord.d/sensu_server.ini /etc/supervisord.d/sensu_server.ini
ADD ./config/supervisord.d/sensu_api.ini /etc/supervisord.d/sensu_api.ini

RUN cp /data/ssl/*.pem /etc/sensu/ssl/
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/victorops.rb -O victorops.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-slack/master/bin/handler-slack.rb -O slack.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-http/master/bin/check-http-json.rb
RUN chmod 755 /etc/sensu/plugins/*.rb

EXPOSE 4567

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
