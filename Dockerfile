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

ARG ENV
ARG SERVER_IP
ARG DOMAIN_NAME
ENV TZ=Asia/Shanghai

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

WORKDIR /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
