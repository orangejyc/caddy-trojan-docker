FROM alpine

LABEL maintainer="ansoya <orangejyc@gmail.com>"

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

ENV TZ Asia/Shanghai

ENV MY_DOMAIN localhost

ENV MY_PWD ansoya

RUN set -e \
    && apk upgrade \
    && apk add bash tzdata mailcap \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

RUN mkdir -vp /var/www/html&&mkdir -vp /etc/caddy&&mkdir -vp /var/log/caddy

ADD ./caddy /usr/bin/caddy
ADD ./index.html /var/www/html/index.html
ADD ./Caddyfile /etc/caddy/Caddyfile
#ADD https://raw.githubusercontent.com/caddyserver/dist/master/config/Caddyfile /etc/caddy/Caddyfile
#ADD https://raw.githubusercontent.com/caddyserver/dist/master/welcome/index.html /usr/share/caddy/index.html

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/golang/go/blob/go1.9.1/src/net/conf.go#L194-L275
# - docker run --rm debian:stretch grep '^hosts:' /etc/nsswitch.conf
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN set -e \
    && apk upgrade \
    && apk add bash tzdata mailcap \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*



VOLUME /var/www/html
VOLUME /etc/caddy
VOLUME /var/log/caddy

EXPOSE 80
EXPOSE 443
EXPOSE 2019

WORKDIR /srv

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
