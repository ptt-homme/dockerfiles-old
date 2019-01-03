# VERSION:        1.0.0
# DESCRIPTION:    Create a container containing siege
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#  	Homepage: https://www.joedog.org/siege-home/
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#   # Use image 
#   docker run -it --rm -v $(pwd):/tmp youralias/image -c 100 -t 60S -v myfile:/tmp -f url.txt

# Base Docker image.
FROM ptt-homme/base
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

# Install utils packages.
RUN apt-get update \
    && apt-get install -y \
      build-essential \
      libssl-dev \
      zlib1g-dev \
   	--no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Download && Install Siege.
RUN wget http://download.joedog.org/siege/siege-4.0.4.tar.gz \
    && tar xvzf siege-4.0.4.tar.gz \
    && cd siege-4.0.4 \
    && ./configure \
    && make \
    && make install

# 
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["siege", "-b", "-i", "--no-parser"]
