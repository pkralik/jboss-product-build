FROM centos

RUN yum -y update && yum -y install git java-1.8.0-openjdk-devel patch unzip wget && yum clean all

WORKDIR /root

ENV HOME /root
ENV M2_HOME $HOME/apache-maven-3.5.2
ENV GRADLE_HOME $HOME/gradle-4.3
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV PATH $M2_HOME/bin:$GRADLE_HOME/bin:$PATH

RUN wget https://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip && unzip apache-maven-3.5.2-bin.zip && rm apache-maven-3.5.2-bin.zip
RUN wget http://central.maven.org/maven2/org/commonjava/maven/ext/pom-manipulation-ext/2.12/pom-manipulation-ext-2.12.jar && mv pom-manipulation-ext-2.12.jar $M2_HOME/lib/ext/

RUN wget https://services.gradle.org/distributions/gradle-4.3-bin.zip && unzip gradle-4.3-bin.zip && rm gradle-4.3-bin.zip

ADD settings.xml .m2/settings.xml

RUN git clone https://github.com/apache/kafka.git
ADD kafka.patch kafka/kafka.patch

RUN cd kafka && patch -p1 -i kafka.patch && gradle && ./gradlew clean && ./gradlew -Pversion=1.0.0.DR1-redhat-1 releaseTarGz
