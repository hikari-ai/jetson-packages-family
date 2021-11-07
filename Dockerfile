#    _      _                                      _
#   (_) ___| |_ ___  ___  _ __    _ __   __ _  ___| | ____ _  __ _  ___  ___
#   | |/ _ \ __/ __|/ _ \| '_ \  | '_ \ / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
#   | |  __/ |_\__ \ (_) | | | | | |_) | (_| | (__|   < (_| | (_| |  __/\__ \
#  _/ |\___|\__|___/\___/|_| |_| | .__/ \__,_|\___|_|\_\__,_|\__, |\___||___/
# |__/                           |_|                         |___/
#   __                 _ _
#  / _| __ _ _ __ ___ (_) |_   _
# | |_ / _` | '_ ` _ \| | | | | |
# |  _| (_| | | | | | | | | |_| |
# |_|  \__,_|_| |_| |_|_|_|\__, |
#                          |___/

# https://github.com/hikari-ai/jetson-packages-family
#
# Copyright (C) 2021 yqlbu <https://jetson.hikariai.net>
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

COPY --from=build /app/public /srv

CMD caddy file-server -listen :"$PORT"
