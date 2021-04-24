FROM phusion/baseimage:master-amd64
WORKDIR /opt
ENV WEB_PORT=80\
  NODE_PORT=20010\
  APP_PORT=20020\
  CENTER_PORT=20030
COPY install_files/o2server /opt/o2server
COPY config_default /opt/o2server/config_default
COPY entrypoint.sh /opt/tools/
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive apt-get install -y fontconfig
ENTRYPOINT ["/opt/tools/entrypoint.sh"]
VOLUME ["/opt/o2server/config", "/opt/o2server/local"]
EXPOSE $WEB_PORT $APP_PORT $CENTER_PORT
HEALTHCHECK CMD curl --connect-timeout 120 --fail http://localhost:$WEB_PORT || exit 1
