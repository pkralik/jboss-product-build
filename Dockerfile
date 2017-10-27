FROM fedora

MAINTAINER Pavel Kralik

RUN yum -y update
RUN yum -y install java-1.8.0-openjdk-devel maven git wget 
RUN yum clean all

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV HOME /root

RUN mkdir -p $HOME/.m2

ADD settings.xml $HOME/.m2/settings.xml

RUN cd $HOME && git clone https://github.com/pkralik/amq-bom-license-generator.git

WORKDIR $HOME/amq-bom-license-generator

RUN ["mvn", "package"]
