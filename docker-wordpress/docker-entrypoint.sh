#!/bin/bash
set -e

SSL_PATH="$WEBROOT/ssl"
FIRST_RUN=$([ ! -d $SSL_PATH ] && echo true || echo false)

# Add defined virtualhosts
if [ -n "$VIRTUAL_HOST" -a "$FIRST_RUN" = 'true' ]; then
	cp /etc/apache2/sites-available/conf/virtualhost.conf /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf

	# Configure SSL for these virtualhosts
	if [ "$SSL" = true ]; then
		mkdir $WEBROOT/ssl
		# Create certificate
		openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/ST=/L=Paris/O=$USER/CN=$VIRTUAL_HOST" -keyout $WEBROOT/ssl/$VIRTUAL_HOST.key -out $WEBROOT/ssl/$VIRTUAL_HOST.cert
		cat /etc/apache2/sites-available/conf/virtualhost-ssl.conf >> /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
		a2enmod ssl
	fi

	sed -i "s/{virtual_host}/$VIRTUAL_HOST/g" /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
	mkdir /var/www/${VIRTUAL_HOST} && cd $_ && chown www-data:www-data .
	a2ensite 001-${VIRTUAL_HOST}
fi

# Activate Xdebug
if [ "$XDEBUG" = 'true' -a "$FIRST_RUN" = 'true' ]; then
	IP=`netstat -nr | grep ^0.0.0.0 | awk  '{print $2}'`
	cp /tmp/xdebug/xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini
	sed -i "s/{REMOTE_IP}/$IP/g" /etc/php/7.1/fpm/conf.d/20-xdebug.ini
else
	rm -rf /etc/php/7.1/fpm/conf.d/20-xdebug.ini
fi

# Activate Xdebug
if [ "$BLACKFIRE" = 'true' -a "$FIRST_RUN" = 'true' ]; then
	wget -O - https://packagecloud.io/gpg.key | apt-key add -
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 37BBEE3F7AD95B3F
	echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list
	apt-get update
	apt-get install blackfire-agent blackfire-php
fi

# Let's start supervisord
exec /usr/bin/supervisord -n
