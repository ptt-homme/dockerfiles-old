#!/bin/bash
set -e

# Install Drupal 7 from a existing repo or drush make.
if ! [ -e index.php ] && ! [ -d sites ]; then

	if [ -n "$PROJECT_GIT_REPO" ]; then
		git clone "$PROJECT_GIT_REPO" .
	else
		~/.composer/vendor/bin/drush make /tmp/makefiles/drupal.make www -y
		cd www/sites/default
		mkdir files && chmod 777 files
		cp -p default.settings.php settings.php
	fi

	chown -R www-data:www-data .

fi

exec "$@"
