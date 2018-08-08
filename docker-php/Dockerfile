# VERSION:        0.1
# DESCRIPTION:    Create a PHP container
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#   NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM tomcreaweb/base
LABEL maintainer "ptt-homme <tomcreaweb@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_VERSION 7.2
ENV WEB_FOLDER /var/www

# Install utils packages.
RUN add-apt-repository -y ppa:ondrej/php \
    && apt-get update && apt-get install -y \
      apache2 \
      build-essential \
      net-tools \
      php${PHP_VERSION}-cli \
      php${PHP_VERSION}-common \
      php${PHP_VERSION}-curl \
      php${PHP_VERSION}-dev \
      php${PHP_VERSION}-fpm \
      php${PHP_VERSION}-gd \
      php${PHP_VERSION}-imap \
      php${PHP_VERSION}-json \
      php${PHP_VERSION}-mbstring \
      php${PHP_VERSION}-mysql \
      php${PHP_VERSION}-sqlite3 \
      php${PHP_VERSION}-soap \
      php${PHP_VERSION}-xml \
      php${PHP_VERSION}-zip \
      php-memcached \
      php-xdebug \
      sqlite3 \
      supervisor \
    --no-install-recommends \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable mod-rewrite and mod-expire.
RUN a2enmod headers expires proxy proxy_fcgi rewrite

RUN mkdir -p /var/run/php \
    && sed -i "s/listen =.*/listen = 127.0.0.1:9000/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

COPY docker-entrypoint.sh /entrypoint.sh
COPY conf/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/apache2 /etc/apache2/sites-available/conf
COPY conf/xdebug /tmp/xdebug

# Expose ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
