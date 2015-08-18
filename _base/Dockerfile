FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

RUN apk add --update-cache build-base libffi-dev ruby ruby-dev

RUN mkdir -p /etc/sensu/conf.d

RUN echo "--no-rdoc --no-ri" > /etc/gemrc
RUN gem install sensu-plugin erubis specific_install
RUN gem specific_install https://github.com/ashmckenzie/sensu.git
