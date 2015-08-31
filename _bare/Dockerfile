FROM gliderlabs/alpine:latest
MAINTAINER ash@the-rebellion.net

ENV HOME /root
ENV TERM ansi
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD ./config/repositories /etc/apk/repositories
ADD ./config/supevisord.conf /etc/supervisord.conf

RUN apk add --update-cache supervisor git bash openssl-dev ca-certificates

RUN mkdir -p /etc/supervisord.d /data/ssl

RUN cd /tmp && git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git
RUN cd /tmp/joemiller.me-intro-to-sensu && ./ssl_certs.sh clean && ./ssl_certs.sh generate
RUN cp /tmp/joemiller.me-intro-to-sensu/server_cert.pem /data/ssl/cert.pem
RUN cp /tmp/joemiller.me-intro-to-sensu/server_key.pem /data/ssl/key.pem
RUN cp /tmp/joemiller.me-intro-to-sensu/testca/cacert.pem /data/ssl/
