FROM centos

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk

WORKDIR /root

ADD settings.xml .m2/settings.xml

RUN yum update -y && yum clean all
RUN yum install -y java-1.8.0-openjdk-devel maven gradle git && yum clean all

RUN git clone https://github.com/pkralik/amq-bom-license-generator.git
RUN cd amq-bom-license-generator && mvn package
