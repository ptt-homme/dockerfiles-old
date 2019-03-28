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
		openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=FR/L=Strasbourg/O=Ptt-homme/CN=$VIRTUAL_HOST" -keyout $WEB_FOLDER/ssl/$VIRTUAL_HOST.key -out $WEB_FOLDER/ssl/$VIRTUAL_HOST.cert
		cat /etc/apache2/sites-available/conf/virtualhost-ssl.conf >> /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
		a2enmod ssl
	fi

	# Configure Virtualhosts
	sed -i "s/{VIRTUAL_HOST}/$VIRTUAL_HOST/g" /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf
	sed -i "s#{PUBLIC_PATH}#$PUBLIC_PATH#g" /etc/apache2/sites-available/001-${VIRTUAL_HOST}.conf

	# Export logs to host
	sed -i "s/\/var\/log\/php${PHP_VERSION}-fpm.log/\/proc\/self\/fd\/2/g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf
	ln -sf /dev/stdout /var/log/apache2/${VIRTUAL_HOST}-access.log
	ln -sf /dev/stdout /var/log/apache2/${VIRTUAL_HOST}-access-ssl.log
	ln -sf /dev/stderr /var/log/apache2/${VIRTUAL_HOST}-error.log
	ln -sf /dev/stderr /var/log/apache2/error.log # @TODO: Refactor :).

	mkdir -p /var/www/${PUBLIC_PATH} && cd $_ && chown www-data:www-data .
	a2ensite 001-${VIRTUAL_HOST}
fi

# Activate Xdebug
if [ "$XDEBUG" = 'true' -a "$FIRST_RUN" != 0 ]; then
	IP=`netstat -nr | grep ^0.0.0.0 | awk  '{print $2}'`
	cp /tmp/xdebug/xdebug.ini /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
	sed -i "s/{REMOTE_IP}/$IP/g" /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
else
	rm -rf /etc/php/${PHP_VERSION}/fpm/conf.d/20-xdebug.ini
fi

# Activate Xdebug
# /etc/init.d/blackfire-agent
if [ "$BLACKFIRE" = 'true' -a "$FIRST_RUN" != 0 ]; then
	wget -q -O - https://packages.blackfire.io/gpg.key | sudo apt-key add -
	echo "deb http://packages.blackfire.io/debian any main" | sudo tee /etc/apt/sources.list.d/blackfire.list
	apt-get update
	apt-get install blackfire-agent blackfire-php
fi

# Let's start supervisord
exec /usr/bin/supervisord -n
