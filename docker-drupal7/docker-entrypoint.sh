#!/bin/bash
set -e

# Create base folder.
PROJECT_PATH=/home/www-data/$PROJECT_URL
mkdir -p $PROJECT_PATH
cd $PROJECT_PATH

if [ ! -d "www" ]; then

	if [ -n "$PROJECT_GIT_REPO" ]; then
		git clone $PROJECT_GIT_REPO www
	else
		/root/.composer/vendor/bin/drush make /tmp/makefiles/drupal.make www -y
		cd www/sites/default
		mkdir files && chmod 777 files
		cp -p default.settings.php settings.php
	fi

	cd $PROJECT_PATH
	chown -R www-data:www-data www

	rm -rf /var/www/html

fi

ln -s "${PROJECT_PATH}/www" /var/www/html

exec apache2-foreground
