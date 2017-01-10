FROM opensuse

# Proxies for local and jenkins build respectively
#ENV http_proxy=http://ABGPROXYA.ABG.FSC.NET:82
#ENV https_proxy=http://ABGPROXYA.ABG.FSC.NET:82
#ENV http_proxy=http://proxy.intern.est.fujitsu.com:8080
#ENV https_proxy=http://proxy.intern.est.fujitsu.com:8080

# glassfish installation
RUN zypper -n in \
  java-1_7_0-openjdk \
  java-1_7_0-openjdk-devel \
  unzip

COPY glassfish-3.1.2.2-unix.sh /tmp/
COPY glassfish-3.1.2.2-silent-installation-answers /tmp/
RUN sh /tmp/glassfish-3.1.2.2-unix.sh -s -a /tmp/glassfish-3.1.2.2-silent-installation-answers

RUN mkdir /etc/container_environment &&\
    echo /opt/glassfish3 > /etc/container_environment/GLASSFISH_HOME &&\
    echo /opt/glassfish3 > /etc/container_environment/GLASSFISH_HOME

ENV GLASSFISH_HOME=/opt/glassfish3
ENV DB_INTERPRETER=psql
ENV JAVA_HOME=/usr

COPY postgresql-9.4.1212.jre6.jar /opt/glassfish3/glassfish/lib/
#-----END-----#

# unpack apache
COPY apache* /opt/
RUN unzip /opt/apache-ant-1.9.6-bin.zip -d /opt/ && \
    rm /opt/apache-ant-1.9.6-bin.zip &&\
    chmod -R 755 /opt/apache-ant-1.9.6/
#-----END-----#

# unpack james
COPY james-2.3.2.1.zip /opt/

RUN unzip /opt/james-2.3.2.1.zip -d /opt/ && \
    rm /opt/james-2.3.2.1.zip &&\
    chmod a+x /opt/james-2.3.2.1/bin/*.sh
#-----END-----#

COPY playground.sql /opt/

RUN mkdir /opt/indexdir && \
	  chmod a+w /opt/indexdir

COPY startAll.sh /opt/
RUN  chmod a+x /opt/startAll.sh

COPY set-hostname.sh /opt/
RUN  chmod a+x /opt/set-hostname.sh

COPY gfpass /opt/
COPY oscm-integrationtests-mockproduct.war /opt/
COPY birt.war /opt/

COPY domains /opt/glassfish3/glassfish/domains

# Set the default command to run when starting the container
CMD ["/opt/startAll.sh"]
