FROM phpdockerio/php:8.2-fpm
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN  apt-get update
RUN  apt-get install -y curl
RUN  curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN  apt-get install supervisor -y
RUN  apt-get -y --no-install-recommends install git
RUN  apt-get -y --no-install-recommends install wget
RUN  apt-get -y --no-install-recommends install php8.2-memcached
RUN  apt-get -y --no-install-recommends install php8.2-yaml
RUN  apt-get -y --no-install-recommends install php8.2-mysql
RUN  apt-get -y --no-install-recommends install php8.2-curl
RUN  apt-get -y --no-install-recommends install php8.2-bcmath
RUN  apt-get -y --no-install-recommends install php8.2-mbstring
RUN  apt-get -y --no-install-recommends install php8.2-gmp
RUN  apt-get -y --no-install-recommends install php8.2-gd
RUN  apt-get -y --no-install-recommends install php8.2-intl
RUN  apt-get -y --no-install-recommends install php8.2-mcrypt