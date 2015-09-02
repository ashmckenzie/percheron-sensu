FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/supervisor.d/rabbitmq.ini /etc/supervisor.d/rabbitmq.ini

RUN apk add --update-cache erlang@edge erlang-eldap@edge erlang-inets@edge \
erlang-xmerl@edge erlang-sasl@edge erlang-ssl@edge erlang-mnesia@edge \
erlang-os-mon@edge erlang-asn1@edge erlang-crypto@edge erlang-public-key@edge libsasl

RUN mkdir -p /opt /etc/rabbitmq/ssl /var/log/rabbitmq /var/lib/rabbitmq/mnesia
ADD ./config/rabbitmq/rabbitmq.config /etc/rabbitmq/rabbitmq.config
RUN sed -i 's%<RABBITMQ_USER>%{{ secrets.rabbitmq.user }}%' /etc/rabbitmq/rabbitmq.config
RUN sed -i 's%<RABBITMQ_PASSWORD>%{{ secrets.rabbitmq.password }}%' /etc/rabbitmq/rabbitmq.config
ADD ./config/rabbitmq/enabled_plugins /etc/rabbitmq/enabled_plugins
RUN cd /tmp && wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.3/rabbitmq-server-generic-unix-3.5.3.tar.gz
RUN cd /opt && tar xzvf /tmp/rabbitmq-server-generic-unix-3.5.3.tar.gz && ln -sf rabbitmq_server-3.5.3 rabbitmq_server && \
rm -f /tmp/rabbitmq-server-generic-unix-3.5.3.tar.gz

RUN cp /data/ssl/*.pem /etc/rabbitmq/ssl/
RUN /opt/rabbitmq_server/sbin/rabbitmq-plugins enable rabbitmq_management

EXPOSE 5671 15672

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
