FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

RUN apk add --update-cache build-base libffi-dev ruby ruby-dev

RUN mkdir -p /etc/sensu/conf.d /etc/sensu/ssl /etc/sensu/plugins /etc/sensu/checks /etc/sensu/handlers /var/log/sensu

RUN cp /data/ssl/*.pem /etc/sensu/ssl/

ADD ./config/sensu/conf.d/rabbitmq.json /etc/sensu/conf.d/rabbitmq.json
ADD ./config/sensu/conf.d/plugin-slack_hilander.json /etc/sensu/conf.d/plugin-slack_hilander.json
ADD ./config/sensu/conf.d/plugin-victorops_hilander.json /etc/sensu/conf.d/plugin-victorops_hilander.json

ADD ./config/sensu/handlers/slack_hilander.json /etc/sensu/handlers/slack_hilander.json
RUN sed -i 's/SLACK_HILANDER_WEBHOOK_URL/{{ secrets.slack_hilander_webhook_url }}/' /etc/sensu/handlers/slack_hilander.json
ADD ./config/sensu/handlers/victorops_hilander.json /etc/sensu/handlers/victorops_hilander.json
RUN sed -i 's/VICTOROPS_HILANDER_API_URL/{{ secrets.victorops_hilander_api_url }}/' /etc/sensu/handlers/slack_hilander.json

RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-slack/master/bin/handler-slack.rb -O slack.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-http/master/bin/check-http-json.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/sensu/check-aggregate.rb
RUN cd /etc/sensu/plugins && wget https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/victorops.rb -O victorops.rb
RUN chmod 755 /etc/sensu/plugins/*.rb

RUN echo 'gem: --no-document' > /etc/gemrc
RUN gem install sensu-plugin erubis specific_install
RUN gem specific_install https://github.com/ashmckenzie/sensu.git
