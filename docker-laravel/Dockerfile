# VERSION:        0.1
# DESCRIPTION:    Create a Laravel 5 container
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
RUN apt-get update && apt-get install -y \
	git \
    libjpeg-dev \
	libmcrypt-dev \
    libpng-dev \
	libssl-dev \
	libxml2-dev \
	unzip \
	vim \
	--no-install-recommends \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install ftp gd mbstring mcrypt mysql pdo_mysql xmlrpc zip \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Install Composer && Laravel installer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require "laravel/installer=~1.1"

# Install Laravel.
WORKDIR /var/www
RUN rm -rf /var/www/html && ~/.composer/vendor/bin/laravel new html

COPY docker-entrypoint.sh /entrypoint.sh

RUN usermod -u 1000 www-data

EXPOSE 80
