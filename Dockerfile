FROM adoptopenjdk/openjdk13:x86_64-ubuntu-jdk-13.0.2_8-slim

WORKDIR /opt/ADITO

ADD https://static.adito.de/common/install/ADITO/ADITODEPLOY_2021.2.3-RC2_unix.tar \
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

RUN mkdir /tmp/asciidoc && \
    cd /tmp/asciidoc && \
    curl https://aditopluginsonline.adito.de/2021.1.0/repository/org.netbeans.asciidoc/org.netbeans.asciidoc.nbm -o asciidoc.nbm && \
    apt update && \
	apt install zip -y && \
	unzip asciidoc.nbm && \
    rm asciidoc.nbm && \
    mv -f netbeans/modules/* /opt/ADITO/lib/designer/deploy/modules/ && \
	mv -f netbeans/config/Modules/* /opt/ADITO/lib/designer/deploy/config/Modules/
	
ENTRYPOINT [ "/run.sh" ]
