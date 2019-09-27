ARG ALPINE_VERSION=3.8

FROM elixir:1.9-alpine AS builder

ARG APP_NAME
ARG APP_VSN
ARG MIX_ENV=prod
ARG SKIP_PHOENIX=true

ENV SKIP_PHOENIX=${SKIP_PHOENIX} \
    APP_NAME=${APP_NAME} \
    APP_VSN=${APP_VSN} \
    MIX_ENV=${MIX_ENV}

WORKDIR /opt/app

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
        nodejs \
        yarn \
        git \
        build-base && \
    mix local.rebar --force && \
    mix local.hex --force

COPY . .
COPY lib/templates/ lib/templates

RUN mix do deps.get, deps.compile, compile

RUN mkdir -p /opt/built && \
    mix distillery.release --verbose && \
    cp _build/${MIX_ENV}/rel/${APP_NAME}/releases/${APP_VSN}/${APP_NAME}.tar.gz /opt/built && \
    cd /opt/built && \
    tar -xzf ${APP_NAME}.tar.gz && \
    rm ${APP_NAME}.tar.gz

FROM alpine:latest

ARG APP_NAME=elixirbot

RUN apk update && \
    apk add --no-cache \
        bash \
        openssl-dev

ENV REPLACE_OS_VARS=true \
    APP_NAME=${APP_NAME}

WORKDIR /opt/app

COPY --from=builder /opt/built .

CMD trap 'exit' INT; /opt/app/bin/${APP_NAME} foreground
