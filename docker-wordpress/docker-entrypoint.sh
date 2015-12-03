#!/bin/bash
set -e

# Create base folder.
PROJECT_PATH=/home/www-data/$PROJECT_URL
mkdir -p $PROJECT_PATH
cd $PROJECT_PATH

if [ -n "$PROJECT_GIT_REPO" ]; then
	git clone $PROJECT_GIT_REPO www
else
	git clone https://github.com/ptt-homme/WordPress_starter.git www
fi

chown -R www-data:www-data www

rm -rf /var/www/html
ln -s "${PROJECT_PATH}/www" /var/www/html

exec apache2-foreground
