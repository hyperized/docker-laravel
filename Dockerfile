FROM hyperized/scratch:latest as trigger
# Used to trigger Docker hubs auto build, which it wont do on the official images

FROM php:7.2-fpm-alpine

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="My Laravel base image, supports Redis and Media operations"

RUN apk --update add libpng freetype imagemagick-libs libjpeg-turbo \
 && apk --update add --virtual build-dependencies autoconf build-base imagemagick-dev libpng-dev freetype-dev libjpeg-turbo-dev \
 && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install gd \
 && docker-php-ext-install bcmath \
 && docker-php-ext-install pdo_mysql \
 && docker-php-ext-install exif \
 && pecl install imagick \
 && docker-php-ext-enable imagick \
 && pecl install redis-4.3.0 \
 && docker-php-ext-enable redis \
 && apk del build-dependencies
