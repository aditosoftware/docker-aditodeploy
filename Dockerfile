FROM ubuntu:18.04

WORKDIR /opt/ADITO

ADD https://static.adito.de/common/install/ADITO/ADITODEPLOY_2019.3.3-RC4_unix.tar \
    /tmp/adito.tar
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
    chmod +x /tmp/installDeploy/ADITO_unix.sh  && \
    chmod +x /run.sh && \
    /tmp/installDeploy/ADITO_unix.sh -q -varfile /tmp/response.varfile && \
    chmod +x /opt/ADITO/bin/ADITOdeploy && \
    rm -rf /tmp/* && \
    rm -Rf /opt/ADITO/webroot

ENTRYPOINT [ "/run.sh" ]
