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
MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Enable mod-rewrite and mod-expire.
RUN a2enmod rewrite expires

# Install utils packages.
RUN apt-get update && apt-get install -y \
	git \
    libjpeg-dev \
	libmcrypt-dev \
    libpng-dev \
	libssl-dev \
	libxml2-dev \
	ssmtp \
	unzip \
	vim \
	--no-install-recommends \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu \
    && docker-php-ext-install ftp gd mbstring mcrypt mysql pdo_mysql xmlrpc zip \
	&& rm -rf /var/lib/apt/lists/*

# Add MailDev.
RUN { \
		echo '[CUSTOM]'; \
		echo 'sendmail_path = /usr/sbin/ssmtp -t'; \
	} > /usr/local/etc/php/conf.d/zzzz_custom.ini \
	&& sed -i 's/=mail/=maildev/1' /etc/ssmtp/ssmtp.conf

RUN usermod -u 1000 www-data

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
