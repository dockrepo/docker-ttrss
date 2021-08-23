FROM wangqiru/ttrss:latest

LABEL maintainer="Zyao89 <zyao89@gmail.com>"

# for mail
RUN apk upgrade --update-cache --available && \
    apk add php8-openssl && \
    rm -rf /var/cache/apk/*

# RUN sed -i "s/;extension=openssl/extension=openssl/" /etc/php8/php.ini

# Download plugins
WORKDIR /var/www/plugins.local

## highlightjs
RUN mkdir -p /var/www/plugins.local/highlightjs && \
  curl -sL https://git.tt-rss.org/fox/ttrss-highlightjs/archive/master.tar.gz | \
  tar xzvpf - --strip-components=1 -C highlightjs ttrss-highlightjs
  
## mailer_smtp
# TTRSS_SMTP_SERVER=localhost:587
# # Use this server (hostname:port). Empty value disables plugin.

# TTRSS_SMTP_LOGIN=
# TTRSS_SMTP_PASSWORD=
# # Login/password for SMTP auth, if needed.

# TTRSS_SMTP_SECURE=tls
# #Use secure connection. Allowed values: `ssl`, `tls`, or empty.

# #TTRSS_SMTP_SKIP_CERT_CHECKS=
# # Accept all SSL certificates, use with caution.

# #TTRSS_SMTP_CA_FILE=
# # Use custom CA certificate for SSL/TLS secure connections. Only used if TTRSS_SMTP_SKIP_CERT_CHECKS is false.
RUN mkdir -p /var/www/plugins.local/mailer_smtp && \
  curl -sL https://git.tt-rss.org/fox/ttrss-mailer-smtp/archive/master.tar.gz | \
  tar xzvpf - --strip-components=1 -C mailer_smtp ttrss-mailer-smtp

# env
COPY ./add_custom_config.sh /add_custom_config.sh
COPY ./ttrss_entrypoint.sh /ttrss_entrypoint.sh
RUN chmod -x /add_custom_config.sh && chmod -x /ttrss_entrypoint.sh

# build date
RUN date +%Y%m%d%H%M%S > /__version__

WORKDIR /var/www

ENTRYPOINT ["sh", "/ttrss_entrypoint.sh"]