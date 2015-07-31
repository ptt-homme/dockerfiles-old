FROM php:5.6-apache

MAINTAINER ptt-homme "tomcreaweb@gmail.com"

# Install utils packages.
RUN apt-get update && apt-get install -y \
	bzip2 \
	unzip \
	zlib1g-dev \
	--no-install-recommends && \
	docker-php-ext-install mbstring mysqli zip && \
	rm -rf /var/lib/apt/lists/*

# Download phpMyAdmin from files.phpmyadmin.net.
ENV PHPMYADMIN_VERSION=4.4.12
ENV PHPMYADMIN_ZIP_MD5=f304876e2ac5056c320dd849195a4bf5
WORKDIR /var/www/

ADD https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.zip /var/www/phpmyadmin.zip
RUN unzip -q phpmyadmin.zip && rm phpmyadmin.zip && rm -rf html && mv `ls` html && ls -lah html/
ADD conf/config.inc.php /var/www/html/config.inc.php
RUN chown -R www-data:www-data /var/www/html/

CMD ["apache2-foreground"]