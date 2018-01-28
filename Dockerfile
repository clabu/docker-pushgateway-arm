FROM alpine:latest

LABEL maintainer "Claes Buckwalter"

ARG ARCH=amd64
ARG VERSION=2.1.0

RUN apk --no-cache add --virtual build-dependencies wget ca-certificates \
    && mkdir -p /tmp/install /tmp/dist \
    && wget -O /tmp/install/pushgateway.tar.gz https://github.com/prometheus/pushgateway/releases/download/v0.4.0/pushgateway-$VERSION.linux-$ARCH.tar.gz \
    && apk del build-dependencies \
    && cd /tmp/install \
    && tar -xzf pushgateway.tar.gz \
    && mv pushgateway /pushgateway \
    && rm -rf /tmp/install

EXPOSE     9091
VOLUME     [ "/pushgateway" ]
WORKDIR    /pushgateway
ENTRYPOINT [ "/pushgateway/bin/pushgateway" ]
