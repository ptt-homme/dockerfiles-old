# VERSION:        0.1
# DESCRIPTION:    Create a Drupal 7 container
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM php:5.6-apache

ENTRYPOINT ["/entrypoint.sh"]

# Enable mod-rewrite.
RUN a2enmod rewrite

# Install utils packages.
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git \
	libfreetype6-dev \
    libjpeg-dev \
	libmcrypt-dev \
    libpng-dev \
	libssl-dev \
	libxml2-dev \
	supervisor \
	unzip \
	vim \
	--no-install-recommends \
    && docker-php-ext-configure gd \
        --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu \
        --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
    && docker-php-ext-install ftp gd mbstring mcrypt pdo_mysql xmlrpc zip \
    && pecl install uploadprogress \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
	&& rm -rf /var/lib/apt/lists/*

# Install Composer & Drush.
WORKDIR /srv
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& composer global require drush/drush:dev-master \
	&& echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc

# Enable uploadprogress module.
RUN echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/docker-php-ext-uploadprogress.ini

COPY docker-entrypoint.sh /entrypoint.sh
COPY makefiles /tmp/makefiles

ENV PROJECT_URL="public"

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 80
