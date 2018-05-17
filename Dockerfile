FROM nvidia/cuda-ppc64le:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER H2o.ai <ops@h2o.ai>

RUN apt-get -y update && \
    apt-get -y install curl default-jre nginx libzmq-dev apache2-utils

RUN curl https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-1.1.4-4/ppc64le-centos7/dai_1.1.4_ppc64le.deb --output /tmp/dai_1.1.4_ppc64le.deb && \
  dpkg -i --force-architecture /tmp/dai_1.1.4_ppc64le.deb && \
  rm /tmp/dai_1.1.4_ppc64le.deb

RUN curl -H 'Cache-Control: no-cache' \
    https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
    | bash

EXPOSE 22
EXPOSE 12345
EXPOSE 54321
EXPOSE 80
EXPOSE 443

COPY run-dai-nimbix.sh /run-dai-nimbix.sh

# Nginx Configuration
COPY NAE/httpredirect.conf /etc/nginx/conf.d/httpredirect.conf
COPY NAE/default /etc/nginx/sites-enabled/default
COPY NAE/dai-site /etc/nginx/sites-enabled/dai-site

# Nimbix Integrations
COPY NAE/url.txt /etc/NAE/url.txt
COPY NAE/help.html /etc/NAE/help.html
COPY NAE/AppDef.json /etc/NAE/AppDef.json
COPY NAE/AppDef.png /etc//NAE/default.png
COPY NAE/screenshot.png /etc/NAE/screenshot.png
