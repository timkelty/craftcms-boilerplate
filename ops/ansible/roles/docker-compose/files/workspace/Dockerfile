FROM  node:alpine

# We need this to avoid permissions errors.
ARG UID
RUN adduser -u $UID -D -S application

#####################################
# Image optimizers:
#####################################
ENV \
  GIFSICLE_VERSION=1.88 \
  JPEGOPTIM_VERSION=1.4.4 \
  OPTIPNG_VERSION=0.7.6 \
  LIBIMAGEQUANT_VERSION=2.9.1 \
  PNGQUANT_VERSION=2.8.0

RUN apk update && apk add \
  libstdc++ \
  libjpeg-turbo \
  libpng \
  && apk add --virtual build-dependencies \
  build-base \
  libjpeg-turbo-dev \
  zlib-dev \
  libpng-dev \
  bash \
  pkgconfig \
  autoconf \
  automake \
  libtool \
  nasm \
  curl

WORKDIR /tmp

# gifsicle
RUN \
  curl -L -O https://github.com/kohler/gifsicle/archive/v$GIFSICLE_VERSION.tar.gz \
  && tar zxf v$GIFSICLE_VERSION.tar.gz \
  && cd gifsicle-$GIFSICLE_VERSION \
  && autoreconf -i && ./configure && make && make install

# jpegoptim
RUN \
  curl -O http://www.kokkonen.net/tjko/src/jpegoptim-$JPEGOPTIM_VERSION.tar.gz \
  && tar zxf jpegoptim-$JPEGOPTIM_VERSION.tar.gz \
  && cd jpegoptim-$JPEGOPTIM_VERSION \
  && ./configure && make && make install

# optipng
RUN \
  curl -L -O http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-$OPTIPNG_VERSION/optipng-$OPTIPNG_VERSION.tar.gz \
  && tar zxf optipng-$OPTIPNG_VERSION.tar.gz \
  && cd optipng-$OPTIPNG_VERSION \
  && ./configure && make && make install

# pngquant
RUN \
  curl -L -O https://github.com/ImageOptim/libimagequant/archive/$LIBIMAGEQUANT_VERSION.tar.gz \
  && tar xzf $LIBIMAGEQUANT_VERSION.tar.gz \
  && curl -L -O https://github.com/pornel/pngquant/archive/$PNGQUANT_VERSION.tar.gz \
  && tar xzf $PNGQUANT_VERSION.tar.gz \
  && mv libimagequant-$LIBIMAGEQUANT_VERSION/* pngquant-$PNGQUANT_VERSION/lib/ \
  && cd pngquant-$PNGQUANT_VERSION \
  && ./configure && make && make install

# svgo
RUN npm install -g svgo

# cleanup
RUN \
  rm -rf /tmp/* \
  && apk del build-dependencies

WORKDIR /app
