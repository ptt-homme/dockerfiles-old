#!/bin/bash
set -e

if [ -z "$VIRTUAL_HOST" ] || [ -z "$IP" ]; then
    echo "No virtualhost defined. Exiting..." >&2
    exit 1
fi
echo "$IP  $VIRTUAL_HOST" >> /etc/hosts

exec siege -b -i --no-parser "$@"