FROM gitlab.fusionary.com:4567/fusionary/devops/dockerfiles/php:latest

# We need this to avoid permissions errors.
ARG UID=82
RUN adduser -u $UID -D -S -G www-data application

COPY ./php.ini /usr/local/etc/php

RUN mkdir /app
WORKDIR /app
VOLUME ["/app"]
