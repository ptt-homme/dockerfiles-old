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
FROM node:alpine
LABEL maintainer "ptt-homme <tomcreaweb@gmail.com>"

# Various config.
ENV HOME /home/user

# Install utils packages.
RUN apk --no-cache add \
		git \
		vim

RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& echo "ssh-add $HOME/.ssh/" > $HOME/.bash_history \
	&& echo 'eval $(ssh-agent)' >> $HOME/.bash_history

# Install ungit.
RUN npm install -g ungit

WORKDIR $HOME
USER user

CMD ["/usr/local/bin/ungit"]
