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

USER root

WORKDIR /app

COPY src .

RUN apk add hugo
RUN hugo version
RUN hugo

# --- Deployment Stage --- #

FROM caddy

ENV PORT 8080

COPY --from=build /app/public /srv

CMD caddy file-server -listen :"$PORT"
