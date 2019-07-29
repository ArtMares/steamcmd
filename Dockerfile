FROM debian:10-slim

MAINTAINER ArtMares <artmares@influ.su>

ARG USER=steamcmd
ARG GROUP=steamcmd
ARG PUID=847
ARG PGID=847

ENV PORT=27015

RUN apt-get update \
    && apt-get install -y lib32gcc1 libc6-dev wget \
    && addgroup --gid "$PGID" --group "$GROUP" \
    && adduser --uid "$PUID" --ingroup "$GROUP" --shell /bin/sh --no-create-home --disabled-password "$USER" || echo "y" \
    && mkdir -p /opt/steamcmd \
    && cd /opt/steamcmd \
    && wget http://media.steampowered.com/client/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz \
    && chown -R "$USER":"$GROUP" /opt/steamcmd \
    && apt-get clean

USER $USER
WORKDIR /opt/steamcmd

EXPOSE $PORT/udp

ENTRYPOINT ["./steamcmd.sh"]