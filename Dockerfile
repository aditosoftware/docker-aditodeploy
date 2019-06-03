FROM ubuntu:18.04

WORKDIR /opt/ADITO

ADD https://static.adito.de/common/install/ADITO/ADITODEPLOY_2019.1.3-RC25_unix.tar
ADD https://static.adito.de/jre/jre-10.0.2_linux-x64_bin.tar.gz /tmp/jar.tar.gz
ADD response.varfile /tmp/response.varfile
ADD run.sh /run.sh

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

RUN tar -xf /tmp/adito.tar -C /tmp/ && \
    tar -xzf /tmp/jar.tar.gz -C /opt && \
    mv /opt/jre* /opt/jre && \
    chmod +x /tmp/install/ADITO_unix.sh  && \
    chmod +x /run.sh && \
    /tmp/install/ADITO_unix.sh -q -varfile /tmp/response.varfile && \
    rm -rf /tmp/*

ENTRYPOINT [ "/run.sh" ]