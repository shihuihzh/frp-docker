FROM alpine
MAINTAINER Howe <shihuihzh@gmail.com>

ARG FRP_VER=0.20.0
ARG FRP_URL=https://github.com/fatedier/frp/releases/download/v$FRP_VER/frp_${FRP_VER}_linux_amd64.tar.gz

ENV SERVER_PORT 7000


RUN apk add --no-cache --virtual curl \
                                tar && \
    mkdir -p /frp/config && cd /frp && \
    curl -sSL $FRP_URL | tar xz --strip 1 && \
    mv frp*.ini config && \
    mv frp* /usr/bin 

USER nobody
EXPOSE $SERVER_PORT
VOLUME ["/frp/config"]

CMD frps -c /frp/config/frps.ini

