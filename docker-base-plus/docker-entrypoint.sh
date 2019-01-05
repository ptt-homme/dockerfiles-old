#!/bin/bash
set -e

cp $HOME/shared_folder/.z "$HOME/.z"

# Let's move on!
exec "$@"
