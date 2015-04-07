# VERSION:        0.1
# DESCRIPTION:    Create a container with Symfony Installer installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
#   Tested on Debian Jessie.
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#
#   # Use Symfony Installer image
#   docker run -it -u $(id -u):$(id -u) -v $(pwd):/tmp youralias/image command OR
#   alias symfony="docker run -it -u $(id -u):$(id -u) -v $(pwd):/tmp youralias/image then symfony command
#

# Base Docker image.
FROM php:latest

MAINTAINER ptt-homme "tomcreaweb@gmail.com"

# Install Symfony Installer.
RUN curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony && \
	chmod a+x /usr/local/bin/symfony

WORKDIR /tmp

ENTRYPOINT ["symfony"]
