#!/bin/bash
set -e

# Install Laravel.
if ! [ -e package.json -a -d app ]; then
	echo >&2 "Laravel not found in $(pwd) - copying now..."
	if [ "$(ls -A)" ]; then
		echo >&2 "WARNING: $(pwd) is not empty - press Ctrl+C now if this is an error!"
		( set -x; ls -A; sleep 10 )
	fi
	tar cf - --one-file-system -C /usr/src/laravel . | tar xf -
	echo >&2 "Complete! Laravel has been successfully copied to $(pwd)"
fi

# Set apache.
sed -i 's,html,html/public,' /etc/apache2/apache2.conf

exec "$@"