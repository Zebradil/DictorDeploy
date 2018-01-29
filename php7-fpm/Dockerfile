FROM php:fpm-alpine3.7

RUN apk update \
 && apk --no-cache add \
                       git \
                       unzip \
                       postgresql-client \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk update \
 && apk --no-cache add \
                       icu-dev \
                       postgresql-dev \
 && docker-php-ext-install \
                           opcache \
                           pdo_pgsql \
                           intl \
 && echo "short_open_tag=off" >> /usr/local/etc/php/conf.d/symfony.ini

COPY ./start.sh /opt/start.sh

WORKDIR /var/www/api

CMD ["/opt/start.sh"]
