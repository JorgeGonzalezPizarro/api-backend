# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/compose/compose-file/#target

#ARG PHP_VERSION=7.2
#ARG NGINX_VERSION=1.15
#ARG VARNISH_VERSION=6.0

FROM php:7.2-fpm-alpine AS api_platform_php

# persistent / runtime deps
RUN apk add --no-cache \
		acl \
		file \
		gettext \
		git \
		postgresql-client \
		 git mysql-client \
	;

ARG APCU_VERSION=5.1.12
RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		libzip-dev \
		postgresql-dev \
		zlib-dev \
	; \
	\
	docker-php-ext-configure zip --with-libzip; \
	docker-php-ext-install -j$(nproc) \
		intl \
		pdo_pgsql \
		pdo_mysql \
		zip \
	; \
	pecl install \
		apcu-${APCU_VERSION} \
	; \
	pecl clear-cache; \
	docker-php-ext-enable \
		apcu \
		opcache \
	; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --no-cache --virtual .api-phpexts-rundeps $runDeps; \
	\
	apk del .build-deps

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY docker/php/php.ini /usr/local/etc/php/php.ini

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN set -eux; \
	composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --classmap-authoritative; \
	composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"


# build for production
ARG APP_ENV=prod

# prevent the reinstallation of vendors at every changes in the source code
COPY composer.json composer.lock ./
RUN set -eux; \
	composer install --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress --no-suggest; \
	composer clear-cache

COPY . ./

RUN set -eux; \
	mkdir -p var/cache var/log; \
	composer dump-autoload --classmap-authoritative --no-dev; \
	composer run-script --no-dev post-install-cmd; \
	chmod +x bin/console; sync
VOLUME /var/www/

COPY docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["php-fpm"]
#FROM nginx:${NGINX_VERSION}-alpine AS api_platform_nginx
#FROM bitnami/nginx:latest
#
#COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
#
#WORKDIR /srv/api
#
#COPY --from=api_platform_php /srv/api/public public/

FROM  registry.access.redhat.com/rhscl/httpd-24-rhel7

COPY docker/apache/httpd.conf /etc/httpd.conf

#COPY . /app/
#COPY ./ /usr/local/apache2/htdocs/Example
COPY ./ /var/www/html/

EXPOSE 8080



#FROM cooptilleuls/varnish:${VARNISH_VERSION}-alpine AS api_platform_varnish
#
#COPY docker/varnish/conf/default.vcl /usr/local/etc/varnish/default.vcl
