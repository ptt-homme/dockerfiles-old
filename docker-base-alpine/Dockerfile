# VERSION:        1.0.0
# DESCRIPTION:    Create a base image container based on Alpine Linux
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#   NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
ARG VERSION=latest
FROM alpine:$VERSION
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

# Install utils packages.
RUN apk add --no-cache \ 
        curl \
        dialog \
        git \
        htop \
        rsync \
        tmux \
        unzip \
        vim \
        wget \
        zip \
        zsh

# Set environment variables.
ENV USER user
ENV HOME "/home/${USER}"
ENV TERM "xterm-256color"

# ensure that custom user exists
RUN set -x \
  && addgroup -g 1000 -S $USER \
  && adduser -u 1000 -D -S -G $USER $USER

COPY src/.zshrc $HOME

# Install Oh My Zsh.
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git "${HOME}/.oh-my-zsh" \
  && chown -R $USER:$USER $HOME

ENTRYPOINT ["/bin/zsh"]
