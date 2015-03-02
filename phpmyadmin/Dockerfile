FROM php:5.6-apache

MAINTAINER ptt-homme "tomcreaweb@gmail.com"

# utils
RUN apt-get update && \
	apt-get install -y unzip && \
	rm -r /var/lib/apt/lists/* && \
	docker-php-ext-install mbstring mysqli

WORKDIR /var/www/html

# phpmyadmin
ADD http://sourceforge.net/projects/phpmyadmin/files/latest/download /var/www/html/phpmyadmin.zip
RUN unzip -q phpmyadmin.zip && rm phpmyadmin.zip && mv `ls` phpmyadmin && ls -lah phpmyadmin/
ADD conf/config.inc.php /var/www/html/phpmyadmin/config.inc.php

CMD ["apache2-foreground"]