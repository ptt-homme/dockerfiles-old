# VERSION:        0.1
# DESCRIPTION:    Create a octobercms container
# AUTHOR:         ptt-homme <tomcreaweb@gmail.com>
# COMMENTS:
#  	NC
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .

# Base Docker image.
FROM php:5.6-apache
MAINTAINER ptt-homme "tomcreaweb@gmail.com"

# Enable mod-rewrite and mod-expire.
RUN a2enmod rewrite expires

# Install utils packages.
RUN apt-get update && apt-get install -y \
	git \
    libjpeg-dev \
	libmcrypt-dev \
    libpng-dev \
	libssl-dev \
	libxml2-dev \
	unzip \
	vim \
	--no-install-recommends \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install ftp gd mbstring mcrypt mysql pdo_mysql xmlrpc zip \
	&& rm -rf /var/lib/apt/lists/*

RUN usermod -u 1000 www-data

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Download octobercms.
WORKDIR /var/www/
ENV OCTOBERCMS_ZIP_MD5=9a53fd245c7a1e88630b61eff326c245
ENV OCTOBERCMS_FILES_ZIP="octobercms.zip"
ADD https://octobercms.com/download ${OCTOBERCMS_FILES_ZIP}
RUN echo "${OCTOBERCMS_ZIP_MD5} ${OCTOBERCMS_FILES_ZIP}" | md5sum -c \
	&& unzip -q ${OCTOBERCMS_FILES_ZIP} \
	&& rm ${OCTOBERCMS_FILES_ZIP} \
	&& rm -rf html \
	&& mv install-master html \
	&& ls -lah html \
	&& chown -R www-data:www-data html 

CMD ["apache2-foreground"]
