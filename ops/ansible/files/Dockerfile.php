FROM gitlab.fusionary.com:4567/fusionary/devops/dockerfiles/php:latest

ARG UID
# We need this to avoid permissions errors.
RUN adduser -u $UID -D -S -G www-data application

COPY ./php.ini /usr/local/etc/php

RUN mkdir /app
COPY . /app
WORKDIR /app
VOLUME ["/app"]
