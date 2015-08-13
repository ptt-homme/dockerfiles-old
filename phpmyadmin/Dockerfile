# VERSION:        0.1
# DESCRIPTION:    Create a container with phpMyAdmin installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#
#   # Run image
#   docker run -d -p 80 --link yourmysqlcontainer:mysql youralias/image

# Base Docker image.
FROM php:5.6-apache

MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Install utils packages.
RUN apt-get update && apt-get install -y \
	bzip2 \
	unzip \
	zlib1g-dev \
	--no-install-recommends && \
	docker-php-ext-install mbstring mysqli zip && \
	rm -rf /var/lib/apt/lists/*

# Download phpMyAdmin from files.phpmyadmin.net.
ENV PHPMYADMIN_VERSION=4.4.13.1
ENV PHPMYADMIN_ZIP_MD5=c589fde5452e3cf31dfe32f1fa92dcea
WORKDIR /var/www/

ADD https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.zip /var/www/phpmyadmin.zip
RUN echo "${PHPMYADMIN_ZIP_MD5} phpmyadmin.zip" | md5sum -c && \
	unzip -q phpmyadmin.zip && \
	rm phpmyadmin.zip && \
	rm -rf html && \
	mv `ls` html && \
	ls -lah html/
ADD conf/config.inc.php /var/www/html/config.inc.php
RUN chown -R www-data:www-data /var/www/html/

CMD ["apache2-foreground"]