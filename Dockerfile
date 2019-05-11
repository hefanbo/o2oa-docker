FROM alpine:3.9 as builder
WORKDIR /opt
ARG INSTALL_FILE=o2server_20190426125713_linux.zip
ARG DOWNLOAD_ROOT=http://www.o2oa.net/download/versions
ADD $DOWNLOAD_ROOT/$INSTALL_FILE .
RUN unzip -q $INSTALL_FILE && sed "1 a \ \ \"autoStart\":\ true," o2server/configSample/node_127.0.0.1.json > o2server/config/node_127.0.0.1.json

FROM phusion/baseimage:0.11
WORKDIR /opt
ENV WEB_PORT=80\
  NODE_PORT=20010\
  APP_PORT=20020\
  CENTER_PORT=20030\
  STORAGE_PORT=20040\
  DATA_PORT=20050\
  DATA_WEB_PORT=20051
COPY --from=builder /opt/o2server /opt/o2server
CMD /opt/o2server/start_linux.sh
VOLUME /opt/o2server/config /opt/o2server/local
EXPOSE $WEB_PORT $APP_PORT $CENTER_PORT
HEALTHCHECK CMD curl --connect-timeout 120 --fail http://localhost:$WEB_PORT || exit 1
