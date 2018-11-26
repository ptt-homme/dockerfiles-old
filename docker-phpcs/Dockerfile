# VERSION:        1.0.0
# DESCRIPTION:    Create a container containing phpcs
# AUTHOR:         ptt-homme <ptt.homme@gmail.com>
# COMMENTS:
#
# USAGE:
#
#   # Build Composer image
#   docker build -t youralias/image .
#   # Use image 
#

# Base Docker image.
FROM ptt-homme/php:7.1
LABEL maintainer "ptt-homme <ptt.homme@gmail.com>"

WORKDIR /tmp

# Download && Install Composer.
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# Download && Install phpcs.
RUN composer global require drupal/coder \
    && composer global require dealerdirect/phpcodesniffer-composer-installer \
    && sed -i '3iexport PATH=$HOME/bin:/usr/local/bin:$HOME/.composer/vendor/bin:$PATH' $HOME/.zshrc \
    && ln -s $HOME/.composer/vendor/bin/phpcs /usr/local/bin/phpcs

ENTRYPOINT ["phpcs"]