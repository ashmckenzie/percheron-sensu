FROM sensu_bare:1.0.0
MAINTAINER ash@the-rebellion.net

RUN apk add --update-cache build-base libffi-dev ruby ruby-dev

RUN mkdir -p /etc/sensu/conf.d

RUN gem install specific_install --no-rdoc --no-ri
RUN gem specific_install https://github.com/ashmckenzie/sensu.git
RUN gem install sensu-plugin erubis --no-rdoc --no-ri
