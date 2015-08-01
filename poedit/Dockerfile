# VERSION:        0.1
# DESCRIPTION:    Create a container with Poedit installed
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
#   Tested on Debian Jessie.
# USAGE:
#
#   # Build Composer image
#   docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY youralias/image
#
#   Do not forget to disable the server access control program for X using sudo xhost +
#

# Base Docker image.
FROM tomcreaweb/wine-devel

MAINTAINER ptt-homme <tomcreaweb@gmail.com>

# Download Poedit.
ENV POEDIT_VERSION=1.8.3
ADD https://download.poedit.net/Poedit-${POEDIT_VERSION}-setup.exe /usr/src/Poedit-${POEDIT_VERSION}-setup.exe
RUN echo "wine-development /usr/src/Poedit-${POEDIT_VERSION}-setup.exe" > /root/.bash_history

CMD [ "bash" ]