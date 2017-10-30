FROM centos

WORKDIR /root

ADD settings.xml .m2/settings.xml

RUN yum -y update && yum -y install java-1.8.0-openjdk-devel maven git && yum clean all

RUN git clone https://github.com/pkralik/amq-bom-license-generator.git
RUN cd amq-bom-license-generator && mvn package
