#!/bin/bash
set -e
source /build/scripts/commons
set -x

# install PHP and its extensions
$apt_get_install \
    php5 \
    php5-cli \
    php5-curl \
    php5-gd \
    php5-imagick \
    php5-imap \
    php5-json \
    php5-ldap \
    php5-mcrypt \
    php5-mongo \
    php5-mysql \
    php5-pgsql \
    php5-redis \
    php5-xdebug

# install Composer
curl -sS https://getcomposer.org/installer | php
mv -v composer.phar /usr/local/bin/composer

# install Apache and its modules
$apt_get_install \
    apache2 \
    apache2-mpm-prefork \
    libapache2-mod-php5
a2enmod mpm_prefork rewrite ssl php5

cp $FILES/etc/my_init.d/50-config-apache /etc/my_init.d/
mkdir /etc/service/apache
cp $FILES/etc/service/apache/run /etc/service/apache/
cp -f $FILES/etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/

exit 0
