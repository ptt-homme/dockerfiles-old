# VERSION:        0.1
# DESCRIPTION:    Create a container with Wine development installed
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

MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Install Wine development.
RUN apt-get update && apt-get install -y \
	wine-development \
	--no-install-recommends && \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y \
	wine32-development \
	--no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

ENV HOME /root
WORKDIR $HOME
