# _     _ _              _       _              _
#| |__ (_) | ____ _ _ __(_) __ _(_)  _ __   ___| |_
#| '_ \| | |/ / _` | '__| |/ _` | | | '_ \ / _ \ __|
#| | | | |   < (_| | |  | | (_| | |_| | | |  __/ |_
#|_| |_|_|_|\_\__,_|_|  |_|\__,_|_(_)_| |_|\___|\__|

# https://github.com/hikari-ai/jetson-packages-family
#
# Copyright (C) 2021 yqlbu <https://hikariai.net>
#
# This is a self-hosted software, liscensed under the MIT License.
# See /License for more information.

# --- Build Stage --- #

FROM alpine:latest as build

RUN apk add hugo
RUN hugo version

USER root

WORKDIR /app
COPY src/ ./

RUN hugo

# --- Deployment Stage --- #

FROM nginx:stable-alpine

COPY --from=build /app/public /usr/share/nginx/html

RUN chmod -R 0777 /usr/share/nginx/html

COPY src/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
