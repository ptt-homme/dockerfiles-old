# VERSION:        1.0.0
# DESCRIPTION:    Create a base image container
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
FROM ubuntu:18.04
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

# Install utils packages.
RUN apt-get update \
    && apt-get install -y \
      apt-utils \
      build-essential \
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
RUN locale-gen en_US.UTF-8

# Set environment variables.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV USER ptt-homme
ENV HOME "/home/${USER}"
ENV TERM "xterm-256color"

# Add a non ROOT user & use zsh as Shell.
RUN addgroup --gid 1000 "${USER}" \
	&& useradd -u 1000 -g "${USER}" -d "${HOME}" "${USER}" \
    && usermod -aG sudo "${USER}" \
	&& chsh -s /bin/zsh "${USER}"

# Remove password prompt for sudo.
RUN sed -i '26s/) ALL/) NOPASSWD:ALL/' /etc/sudoers

# Install Oh My Zsh.
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git "${HOME}/.oh-my-zsh" \
	&& chown -R "${USER}":"${USER}" "${HOME}" \
    && find "${HOME}" -type f -exec chmod 644 {} \;

USER ptt-homme

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

RUN /home/linuxbrew/.linuxbrew/bin/brew install bat \
    && /home/linuxbrew/.linuxbrew/bin/brew install z \
    && /home/linuxbrew/.linuxbrew/bin/brew install fzf \
    && /home/linuxbrew/.linuxbrew/bin/brew install wrk \
    && /home/linuxbrew/.linuxbrew/bin/brew install exa

# Add configuration files.
COPY src/.zshrc "${HOME}/"
COPY docker-entrypoint.sh /entrypoint.sh
COPY src/my_functions.zsh "$HOME/.oh-my-zsh/custom/my_functions.zsh"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/zsh"]