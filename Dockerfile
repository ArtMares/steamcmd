FROM debian:10-slim

MAINTAINER ArtMares <artmares@influ.su>

ARG USER=steamcmd
ARG GROUP=steamcmd
ARG PUID=847
ARG PGID=847

ENV PORT=27015

RUN apt get update \
    && apt-get install -y lib32gcc1 \
    && apt-get -t experimental install libc6-dev \
    && addgroup -g "$PGID" -S "$GROUP" \
    && adduser -u "$PUID" -G "$GROUP" -s /bin/sh -SDH "$USER" \
    && mkdir -p /opt/steamcmd \
    && cd /opt/steamcmd \
    && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz \
    && chown -R "$USER":"$GROUP" /opt/steamcmd

WORKDIR /opt/steamcmd

EXPOSE $PORT/udp

ENTRYPOINT ["/opt/steamcmd.sh"]