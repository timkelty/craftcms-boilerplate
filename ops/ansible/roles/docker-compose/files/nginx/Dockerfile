FROM nginx:alpine


RUN mkdir /app
WORKDIR /app

COPY ./vhost.conf /etc/nginx/conf.d/default.conf
