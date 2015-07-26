FROM webcenter/yeoman:1.4.7

MAINTAINER Sebastien Langoureaux <linuxworkgroup@hotmail.com>


ENV TOMCAT_VERSION 8.0.24

USER root

RUN apt-get update && \
    apt-get install maven openjdk-8-jdk -y && \
	rm -rf /var/lib/apt/lists/*	

# Install Eclipse Kepler
RUN curl http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/kepler/SR2/eclipse-jee-kepler-SR2-linux-gtk-x86_64.tar.gz -Lo "/tmp/eclipse.tar.gz" 

RUN mkdir -p /opt/eclipse
RUN tar -xf /tmp/eclipse.tar.gz --strip-components=1 -C /opt/eclipse
RUN rm /tmp/eclipse.tar.gz
RUN ln -s /opt/eclipse/eclipse /usr/bin/eclipse

#RUN sysctl -w fs.inotify.max_user_watches=1048576
#RUN echo fs.inotify.max_user_watches=1048576 | tee -a /etc/sysctl.conf && sysctl -p

# Install Tomcat 8 to use it with intellij
RUN curl http://mirrors.ircam.fr/pub/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -Lo "/tmp/tomcat.tar.gz"
RUN mkdir -p /opt/tomcat
RUN tar -xf /tmp/tomcat.tar.gz --strip-components=1 -C /opt/tomcat
RUN rm /tmp/tomcat.tar.gz


USER dev

RUN mkdir /home/dev/workspace

WORKDIR /app

# For intellij setting
VOLUME ["/home/dev/"]

# For current project
VOLUME ["/app"]

CMD ["eclipse"]
