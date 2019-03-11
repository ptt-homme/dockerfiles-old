# VERSION:        1.0.0
# DESCRIPTION:    Create a base image container
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
ARG USER=ptt-homme
FROM ubuntu:18.04
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

# Install utils packages.
RUN apt-get update \
    && apt-get install -y \
      apt-utils \
      curl \
      dialog \
      git \
      htop \
      locales \
      rsync \
      software-properties-common \
      sudo \
      tmux \
      unzip \
      vim \
      wget \
      zip \
      zsh \
   	--no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Change language to french.
RUN locale-gen fr_FR.UTF-8

# Set environment variables.
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ARG USER
ENV HOME "/home/$USER"
ENV TERM "xterm-256color"

# Add Oh My Zsh config.
COPY src/.zshrc "${HOME}/"

# Add a non ROOT user & use zsh as Shell.
RUN addgroup --gid 1000 "$USER" \
	&& useradd -u 1000 -g "$USER" -d "${HOME}" $USER \
    && usermod -aG sudo "$USER" \
	&& chsh -s /bin/zsh "$USER"

# Remove password prompt for sudo.
RUN sed -i '26s/) ALL/) NOPASSWD:ALL/' /etc/sudoers

# Install Oh My Zsh.
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git "${HOME}/.oh-my-zsh" \
	&& chown -R "$USER":"$USER" "${HOME}" \
    && find "${HOME}" -type f -exec chmod 644 {} \;  

ENTRYPOINT ["/usr/bin/zsh"]
