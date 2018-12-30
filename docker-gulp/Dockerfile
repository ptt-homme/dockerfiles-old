# VERSION:        0.2
# DESCRIPTION:    Create a NPM and Gulp container
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#   NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM ptt-homme/base-alpine:edge
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

# Install utils packages.
RUN apk add --no-cache \
    build-base \
    nodejs \
    npm \ 
    python \
    && npm install -g npm@latest \
    && npm install -g gulp

# Install dumb-init.
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /opt
VOLUME ["/opt"]

# Use dumb-init as entrypoint to avoid SIGINT failed to kill node process (PID 1).
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["gulp", "watch"]
