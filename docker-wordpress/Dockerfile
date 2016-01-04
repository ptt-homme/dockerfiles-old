# VERSION:        0.1
# DESCRIPTION:    Create a WordPress container
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM php:5.6-apache
MAINTAINER ptt-homme "tomcreaweb@gmail.com"

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
    && docker-php-ext-install ftp gd mbstring mcrypt mysql pdo_mysql xmlrpc zip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
	&& rm -rf /var/lib/apt/lists/*

ENV PROJECT_URL="public"

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 80
