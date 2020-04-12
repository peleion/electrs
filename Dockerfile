FROM rust:1.34.0-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV ELECTRS_VERSION=v0.8.3

#COPY ./ /srv

#WORKDIR /srv

RUN apt-get update; \
    apt-get install -y clang cmake git libsnappy-dev; \
    cd /usr/local/src; \
    git clone -b ${ELECTRS_VERSION} https://github.com/romanz/electrs; \
    cd electrs; \
    cargo build --release; \
    cargo install --path .; \
    apt-get purge -y --auto-remove clang cmake git; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

#VOLUME /srv

# Electrum RPC
EXPOSE 50001

# Prometheus monitoring
EXPOSE 4224

STOPSIGNAL SIGINT
