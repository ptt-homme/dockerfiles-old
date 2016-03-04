#!/bin/bash
set -e

# Install WordPress.
if ! [ -e index.php ] && ! [ -d wp-content ]; then

	if [ -n "$PROJECT_GIT_REPO" ]; then
		git clone $PROJECT_GIT_REPO .
	else
		git clone https://github.com/ptt-homme/WordPress_starter.git .
	fi

	chown -R www-data:www-data .

fi

exec "$@"
