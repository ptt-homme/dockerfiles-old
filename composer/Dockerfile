# VERSION:        0.1
# DESCRIPTION:    Create a container with Composer installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
#   Tested on Debian Jessie.
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#

# Base Docker image.
FROM debian:jessie

MAINTAINER ptt-homme "tomcreaweb@gmail.com"

# Install dependencies.
RUN apt-get update && \
	apt-get install -y curl php5-curl php5-cli php5-json git

WORKDIR /srv

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ENTRYPOINT ["/usr/local/bin/composer"]
