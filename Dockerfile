FROM centos:centos7

MAINTAINER ViaQ Development <TBD>

USER 0

ENV HOME=/opt/app-root/src \
  JAVA_VER=1.8.0 \
  CEREBRO_VER=0.6.5 \
  CEREBRO_CONF=/usr/share/elasticsearch/config

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum install -y --setopt=tsflags=nodocs \
                java-1.8.0-openjdk-headless \
                && \
	yum update -y && \
    yum clean all

RUN mkdir -p ${HOME} \
    && cd ${HOME} \
    && curl -L -o cerebro-${CEREBRO_VER}.tgz https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VER}/cerebro-${CEREBRO_VER}.tgz \
    && tar zxvf cerebro-${CEREBRO_VER}.tgz \
    && rm cerebro-${CEREBRO_VER}.tgz \
    && mkdir cerebro-${CEREBRO_VER}/logs \
    && mv cerebro-${CEREBRO_VER} cerebro

WORKDIR ${HOME}
USER 1000
CMD ["/opt/app-root/src/bin/cerebro"]
