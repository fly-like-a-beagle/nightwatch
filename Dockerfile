#
# Nightwatch.js Dockerfile
#

FROM alpine:3.4



MAINTAINER Sebastian Tschan <mail@blueimp.net>

RUN apk --no-cache add \
    # Install tini, a tiny but valid init for containers:
    tini \
    # Install NodeJS:
    nodejs-lts \
    # Install ffmpeg for video recording:
    ffmpeg

RUN npm install -g nightwatch@'<1.0'
RUN npm install -g chance-cli

RUN apk add --no-cache bash gawk sed grep bc coreutils

# Add node system user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN adduser -D -u 1000 node

USER node

WORKDIR /home/node

COPY wait-for.sh /usr/local/bin/wait-for
COPY entrypoint.sh /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]
