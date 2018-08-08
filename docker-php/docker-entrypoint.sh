#!/bin/bash
set -e

if [ -f "$WEB_FOLDER/first-run.state" ]; then
	FIRST_RUN=0
fi

if [ "$FIRST_RUN" != 0 ]; then
	touch "$WEB_FOLDER/first-run.state"
fi

# Add defined virtualhosts
if [ -n "$VIRTUAL_HOST" -a "$FIRST_RUN" != 0 ]; then
	if [ $PUBLIC_PATH ]; then PUBLIC_PATH="$VIRTUAL_HOST/$PUBLIC_PATH"; else PUBLIC_PATH=$VIRTUAL_HOST; fi
	cp /etc/apache2/sites-available/conf/virtualhost.conf /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf

	# Configure SSL for these virtualhosts
	if [ "$SSL" = 'true' ]; then
		mkdir $WEB_FOLDER/ssl
		# Create certificate
		openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/ST=/L=Strasbourg/O=Ptt-homme/CN=$VIRTUAL_HOST" -keyout $WEB_FOLDER/ssl/$VIRTUAL_HOST.key -out $WEB_FOLDER/ssl/$VIRTUAL_HOST.cert
		cat /etc/apache2/sites-available/conf/virtualhost-ssl.conf >> /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
		a2enmod ssl
	fi

	sed -i "s/{VIRTUAL_HOST}/$VIRTUAL_HOST/g" /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
	sed -i "s#{PUBLIC_PATH}#$PUBLIC_PATH#g" /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
	mkdir -p /var/www/${PUBLIC_PATH} && cd $_ && chown www-data:www-data .
	a2ensite 001-${VIRTUAL_HOST}
fi

# Activate Xdebug
if [ "$XDEBUG" = 'true' -a "$FIRST_RUN" != 0 ]; then
	IP=`netstat -nr | grep ^0.0.0.0 | awk  '{print $2}'`
	cp /tmp/xdebug/xdebug.ini /etc/php/7.2/fpm/conf.d/20-xdebug.ini
	sed -i "s/{REMOTE_IP}/$IP/g" /etc/php/7.2/fpm/conf.d/20-xdebug.ini
else
	rm -rf /etc/php/7.2/fpm/conf.d/20-xdebug.ini
fi

# Activate Xdebug
# /etc/init.d/blackfire-agent
if [ "$BLACKFIRE" = 'true' -a "$FIRST_RUN" != 0 ]; then
	wget -O - https://packagecloud.io/gpg.key | apt-key add -
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 37BBEE3F7AD95B3F
	echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list
	apt-get update
	apt-get install blackfire-agent blackfire-php
fi

# Let's start supervisord
exec /usr/bin/supervisord -n
