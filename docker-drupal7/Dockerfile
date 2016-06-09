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
MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Enable mod-rewrite and mod-expire.
RUN a2enmod rewrite expires

# Install utils packages and enable uploadprogress module.
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	git \
    libjpeg-dev \
	libmcrypt-dev \
    libpng-dev \
	libssl-dev \
	libxml2-dev \
	mysql-client \
	ssmtp \
	supervisor \
	unzip \
	vim \
	--no-install-recommends \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install ftp gd mbstring mcrypt pdo_mysql xmlrpc zip \
    && pecl install uploadprogress \
    && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/docker-php-ext-uploadprogress.ini \
	&& rm -rf /var/lib/apt/lists/*

# Add MailDev.
RUN { \
		echo '[CUSTOM]'; \
		echo 'sendmail_path = /usr/sbin/ssmtp -t'; \
	} > /usr/local/etc/php/conf.d/zzzz_custom.ini \
	&& sed -i 's/=mail/=maildev/1' /etc/ssmtp/ssmtp.conf

# Install Composer & Drush.
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& composer global require drush/drush:~8 \
	&& echo 'export PATH="/root/.composer/vendor/bin:$PATH"' >> /root/.bashrc \
	&& echo 'alias tbch="chown -R www-data:www-data ."' >> /root/.bashrc

RUN usermod -u 1000 www-data

COPY docker-entrypoint.sh /entrypoint.sh
COPY makefiles /tmp/makefiles

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
