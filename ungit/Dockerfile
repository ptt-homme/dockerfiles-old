# VERSION:        0.1
# DESCRIPTION:    Create a container with ungit installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#
#   # Run image
#   docker run -d -p 8448:8448 -v $PWD:/home/user/src -v ~/.ssh:/home/user/.ssh youralias/image

# Base Docker image.
FROM node:5.0.0
MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Install utils packages.
RUN apt-get update && apt-get install -y \
	vim \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Install ungit.
RUN npm install -g ungit

# Various config.
ENV HOME /home/user

RUN useradd --create-home --home-dir $HOME -g www-data user && \
	chown user:user $HOME && \
	echo "ssh-add $HOME/.ssh/" > $HOME/.bash_history && \
	echo 'eval $(ssh-agent)' >> $HOME/.bash_history

WORKDIR $HOME
USER user

CMD [ "/usr/local/bin/ungit" ]
