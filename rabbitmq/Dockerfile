FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

ADD ./config/supervisor.d/rabbitmq.ini /etc/supervisor.d/rabbitmq.ini

RUN apk add --update-cache libsasl erlang@community erlang-eldap@community erlang-inets@community \
erlang-xmerl@community erlang-sasl@community erlang-ssl@community erlang-mnesia@community \
erlang-os-mon@community erlang-asn1@community erlang-crypto@community erlang-public-key@community

RUN mkdir -p /opt /etc/rabbitmq/ssl /var/log/rabbitmq /var/lib/rabbitmq/mnesia
ADD ./config/rabbitmq/rabbitmq.config /etc/rabbitmq/rabbitmq.config
RUN sed -i 's%<RABBITMQ_USER>%{{ secrets.rabbitmq.user }}%' /etc/rabbitmq/rabbitmq.config
RUN sed -i 's%<RABBITMQ_PASSWORD>%{{ secrets.rabbitmq.password }}%' /etc/rabbitmq/rabbitmq.config
ADD ./config/rabbitmq/enabled_plugins /etc/rabbitmq/enabled_plugins
RUN cd /tmp && wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.7/rabbitmq-server-generic-unix-3.5.7.tar.gz
RUN cd /opt && tar xzvf /tmp/rabbitmq-server-generic-unix-3.5.7.tar.gz && ln -sf rabbitmq_server-3.5.7 rabbitmq_server && \
rm -f /tmp/rabbitmq-server-generic-unix-3.5.7.tar.gz

RUN cp /data/ssl/*.pem /etc/rabbitmq/ssl/
RUN /opt/rabbitmq_server/sbin/rabbitmq-plugins enable rabbitmq_management

EXPOSE 5671 15672

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
