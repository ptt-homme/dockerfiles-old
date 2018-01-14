# VERSION:        0.2
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
#   docker run -d -p 8448:8448 -v $PWD:/home/node/src -v ~/.ssh:/home/node/.ssh youralias/image

# Base Docker image.
FROM node:alpine
LABEL maintainer "ptt-homme <tomcreaweb@gmail.com>"

# Various config.
ENV HOME /home/node

# Install utils packages.
RUN apk add --no-cache \
	 	git \
	 	openssh-client \
		vim

# Add some ssh stuffs.
RUN echo "ssh-add $HOME/.ssh/" > $HOME/.bash_history \
	&& echo 'eval $(ssh-agent)' >> $HOME/.bash_history

# Install ungit.
RUN npm install -g ungit

WORKDIR $HOME
USER node

CMD ["/usr/local/bin/ungit"]
