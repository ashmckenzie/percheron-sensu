FROM gliderlabs/alpine:edge
MAINTAINER ash@the-rebellion.net

ENV HOME /root
ENV TERM ansi
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD ./config/repositories /etc/apk/
ADD ./config/supervisord.conf /etc/

RUN apk add --update-cache supervisor git bash openssl openssl-dev ca-certificates

RUN mkdir -p /etc/supervisor.d /data/ssl

RUN git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git /tmp/joemiller.me-intro-to-sensu

WORKDIR /tmp/joemiller.me-intro-to-sensu
RUN ./ssl_certs.sh clean && ./ssl_certs.sh generate
RUN cp ./server_cert.pem /data/ssl/cert.pem
RUN cp ./server_key.pem /data/ssl/key.pem
RUN cp ./testca/cacert.pem /data/ssl/
