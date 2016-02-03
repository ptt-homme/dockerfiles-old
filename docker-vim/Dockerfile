# VERSION:        0.1
# DESCRIPTION:    Create a container with vim installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#
#   # Run image
#   docker run -it youralias/image

# Base Docker image.
FROM ubuntu:latest

MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Set the locale.
RUN locale-gen fr_FR fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

# Install utils packages.
RUN apt-get update && apt-get install -y \
    ca-certificates \
    ctags \
    curl \
    fontconfig \
    git \
    openssl \
    unzip \
    vim \
    wget \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Create and set user.
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

WORKDIR $HOME
USER user

# Install vim distribution and Powerline Symbols fonts.
RUN curl http://j.mp/spf13-vim3 -L -o - | sh \
    && mkdir -p $HOME/.fonts $HOME/.config/fontconfig/conf.d \
    && wget -P $HOME/.fonts                     https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf \
    && wget -P $HOME/.config/fontconfig/conf.d https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf \
    && fc-cache -vf $HOME/.fonts/

CMD ["bash"]
