FROM adoptopenjdk/openjdk13:x86_64-ubuntu-jdk-13.0.1_9-slim

WORKDIR /opt/ADITO

ADD https://static.adito.de/common/install/ADITO/ADITODEPLOY_2020.0.0-TEST11_unix.tar \
    /tmp/adito.tar
ADD response.varfile /tmp/response.varfile
ADD run.sh /run.sh

ENV INSTALL4J_JAVA_HOME=$JAVA_HOME

RUN tar -xf /tmp/adito.tar -C /tmp/ && \
    chmod +x /tmp/installDeploy/ADITO_unix.sh  && \
    chmod +x /run.sh && \
    /tmp/installDeploy/ADITO_unix.sh -q -varfile /tmp/response.varfile && \
    chmod +x /opt/ADITO/bin/ADITOdeploy && \
    rm -rf /tmp/* && \
    rm -Rf /opt/ADITO/webroot

ENTRYPOINT [ "/run.sh" ]
