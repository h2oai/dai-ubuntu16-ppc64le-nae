FROM nvidia/cuda-ppc64le:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER H2o.ai <ops@h2o.ai>

RUN apt-get -y update && \
    apt-get -y install curl && \
    apt-get -y install default-jre

RUN curl https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-1.1.0.cuda9-1/ppc64le-centos7/dai_1.1.0_ppc64le.deb --output dai_1.1.0_ppc64le.deb

RUN dpkg -i --force-architecture dai_1.1.0_ppc64le.deb

RUN curl -H 'Cache-Control: no-cache' \
    https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
    | bash

RUN chown -R nimbix:nimbix /opt/h2oai

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22
EXPOSE 12345
EXPOSE 54321



COPY run-dai-nimbix.sh /run-dai-nimbix.sh

# Nimbix Integrations
COPY NAE/url.txt /etc/NAE/url.txt
COPY NAE/help.html /etc/NAE/help.html
COPY NAE/AppDef.json /etc/NAE/AppDef.json
COPY NAE/AppDef.png /etc//NAE/default.png
COPY NAE/screenshot.png /etc/NAE/screenshot.png
