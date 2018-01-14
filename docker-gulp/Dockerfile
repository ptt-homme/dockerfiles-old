# VERSION:        0.1
# DESCRIPTION:    Create a NPM and Gulp container
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#   NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#
#	# Run the container
#	docker run --rm -v $(pwd):/opt youralias/image
#

# Base Docker image.
FROM tomcreaweb/base
LABEL maintainer "ptt-homme <tomcreaweb@gmail.com>"

WORKDIR /opt

# Install Node.js.
ADD https://deb.nodesource.com/setup_9.x /tmp/setup_9.x
RUN bash /tmp/setup_9.x
RUN apt-get update && apt-get install -y \
			build-essential \
		 	libnotify-bin \
		--no-install-recommends \
		&& apt-get install -y nodejs \
		&& /usr/bin/npm install -g gulp \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dumb-init.
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb /tmp/dumb-init_1.2.1_amd64.deb
RUN dpkg -i /tmp/dumb-init_*.deb

VOLUME ["/opt"]

# Use dumb-init as entrypoint to avoid SIGINT failed to kill node process (PID 1).
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["gulp", "watch"]
