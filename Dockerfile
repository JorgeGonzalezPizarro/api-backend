FROM composer as backend

WORKDIR /app

COPY composer.json composer.lock /app/
RUN composer install  \
    --ignore-platform-reqs \
    --no-ansi \
    --no-autoloader \
    --no-dev \
    --no-interaction \
    --no-scripts

COPY . /app/
RUN composer dump-autoload --no-dev --optimize --classmap-authoritative
RUN cd /app/ composer update

FROM php:7.1-apache

RUN apt-get update  && apt-get install -y git vim curl debconf subversion git apt-transport-https apt-utils zlib1g-dev

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#RUN composer install  \
# &&   --ignore-platform-reqs \
# &&   --no-ansi \
# &&   --no-dev \
# &&   --no-interaction \
# &&   --no-scripts

RUN pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo pdo_mysql \
    && chown -R www-data:www-data /var/www/

#COPY /docker/apache/httpd.conf $APACHE_CONFDIR/httpd.conf
#COPY composer.json composer.lock ./
#RUN set -eux; \
#RUN composer install --no-dev --no-interaction --optimize-autoloader

COPY --from=backend /app  /var/www

#RUN composer dump-autoload --no-dev --optimize --classmap-authoritative


#RUN composer dump-autoload
VOLUME ${PWD}: /var/www

#RUN  chmod# -R 755 /var/www
COPY /docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY /docker/php/php.ini $PHP_INI_DIR
COPY /docker/php/php.ini /usr/local/php
COPY /docker/php/php.ini /usr/local/lib/php/
WORKDIR /var/www