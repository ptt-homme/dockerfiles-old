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
FROM php:5-alpine
MAINTAINER ptt-homme <tomcreaweb@gmail.com>

RUN addgroup -g 1000 user \
	&& adduser -D -h /home/user -G user -u 1000 user

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chown user:user /usr/local/bin/composer

USER user

WORKDIR /tmp

ENTRYPOINT ["/usr/local/bin/composer"]
