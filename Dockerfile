FROM wangqiru/ttrss:latest

LABEL maintainer="Zyao89 <zyao89@gmail.com>"

# for mail
RUN apk upgrade --update --no-cache --available \
    && apk add php81-openssl \
    && rm -rf /var/cache/apk/*

# RUN sed -i "s/;extension=openssl/extension=openssl/" /etc/php8/php.ini

# Download plugins
WORKDIR /var/www/plugins.local

## highlightjs
RUN mkdir -p /var/www/plugins.local/highlightjs && \
  curl -sL https://git.tt-rss.org/fox/ttrss-highlightjs.git/archive/master.tar.gz | \
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

# https://git.tt-rss.org/fox/ttrss-names-to-tags.git
# names_to_tags
RUN mkdir -p /var/www/plugins.local/names_to_tags && \
  curl -sL https://git.tt-rss.org/fox/ttrss-names-to-tags/archive/master.tar.gz | \
  tar xzvpf - --strip-components=1 -C names_to_tags ttrss-names-to-tags

# https://git.tt-rss.org/fox/ttrss-labels-to-tags.git
# labels_to_tags
RUN mkdir -p /var/www/plugins.local/labels_to_tags && \
  curl -sL https://git.tt-rss.org/fox/ttrss-labels-to-tags/archive/master.tar.gz | \
  tar xzvpf - --strip-components=1 -C labels_to_tags ttrss-labels-to-tags

# https://github.com/alekc/af_refspoof.git
# af_refspoof
COPY ./plugins/af_refspoof/* /var/www/plugins.local/af_refspoof/


# env
COPY ./add_custom_config.sh /add_custom_config.sh
COPY ./ttrss_entrypoint.sh /ttrss_entrypoint.sh
RUN chmod -x /add_custom_config.sh && chmod -x /ttrss_entrypoint.sh

# build date
RUN date +%Y%m%d%H%M%S > /__version__

WORKDIR /var/www

ENTRYPOINT ["sh", "/ttrss_entrypoint.sh"]
