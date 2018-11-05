# VERSION:        0.1
# DESCRIPTION:    Create a PHP container
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#   NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM ptt-homme/base
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_VERSION 7.1
ENV WEB_FOLDER /var/www

# Download libapache-mod-fastcgi.
RUN wget http://mirrors.kernel.org/ubuntu/pool/multiverse/liba/libapache-mod-fastcgi/libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb -P /tmp

# Install utils packages.
RUN add-apt-repository -y ppa:ondrej/php \
    && apt-get update && apt-get install -y \
      apache2 \
      build-essential \
      gnupg \
      net-tools \
      php${PHP_VERSION}-cgi \
      php${PHP_VERSION}-cli \
      php${PHP_VERSION}-common \
      php${PHP_VERSION}-curl \
      php${PHP_VERSION}-dev \
      php${PHP_VERSION}-fpm \
      php${PHP_VERSION}-gd \
      php${PHP_VERSION}-imap \
      php${PHP_VERSION}-intl \
      php${PHP_VERSION}-json \
      php${PHP_VERSION}-mbstring \
      php${PHP_VERSION}-mcrypt \
      php${PHP_VERSION}-mysql \
      php${PHP_VERSION}-opcache \
      php${PHP_VERSION}-sqlite3 \
      php${PHP_VERSION}-soap \
      php${PHP_VERSION}-xml \
      php${PHP_VERSION}-zip \
      php-memcached \
      php-xdebug \
      sqlite3 \
      supervisor \
    --no-install-recommends \
    && dpkg -i /tmp/libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb; apt install -f \
    && rm /tmp/libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable mod-rewrite and mod-expire.
RUN a2enmod headers expires proxy proxy_fcgi rewrite

# This lets supervisord be able to start PHP.
RUN mkdir -p /var/run/php

# Add configuration files.
COPY docker-entrypoint.sh /entrypoint.sh
COPY conf/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/apache2 /etc/apache2/sites-available/conf
COPY conf/xdebug /tmp/xdebug

# Expose ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
