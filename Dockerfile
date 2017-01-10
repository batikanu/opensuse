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

# postgresql94 installation
RUN zypper addrepo -t YUM http://packages.2ndquadrant.com/postgresql-z-suse/zypper/sles-11sp3-s390x pg
RUN zypper -n --no-gpg-checks refresh
RUN zypper -n in postgresql94-server \
    sudo

USER postgres

ENV PGDATA=/var/lib/pgsql/database

RUN mkdir $PGDATA

RUN initdb

RUN pg_ctl start && \
    sleep 2 && \
    psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

COPY pg_hba.conf postgresql.conf /var/lib/pgsql/database/
#-----END-----#

USER root

# unpack oscm installation
COPY oscm* /opt/
RUN unzip /opt/oscm-install-pack.zip -d /opt/oscm-install-pack && \
    rm /opt/oscm-install-pack.zip
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

# deployment
COPY configsettings.properties /opt/oscm-install-pack/databases/bes_db/
COPY playground.sql /opt/
COPY glassfish_bes.properties /opt/oscm-install-pack/domains/bes_domain/glassfish.properties
COPY glassfish_mid.properties /opt/oscm-install-pack/domains/indexer_domain/glassfish.properties

RUN mkdir /opt/indexdir && \
	  chmod a+w /opt/indexdir

RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 3 &&\
	  /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml setParam &&\
    /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml CREATE.dbsAndUsers &&\
    sudo -u postgres PGPASSWORD=postgres psql -Upostgres -f /opt/playground.sql bss &&\
    /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml UPDATE.dbSchema &&\
    /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml UPDATE.configSettings &&\
    /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-glassfish.xml SETUP

COPY gfpass /opt/
COPY oscm-integrationtests-mockproduct.war /opt/
COPY birt.war /opt/
RUN /opt/glassfish3/glassfish/bin/asadmin start-domain bes-domain && /opt/glassfish3/glassfish/bin/asadmin --port 8048 --user admin --passwordfile /opt/gfpass enable-secure-admin && \
    /opt/glassfish3/glassfish/bin/asadmin deploy /opt/oscm-integrationtests-mockproduct.war --port 8048 --user admin --passwordfile /opt/gfpass && \
    /opt/glassfish3/glassfish/bin/asadmin deploy /opt/birt.war --port 8048 --user admin --passwordfile /opt/gfpass &&\
    /opt/glassfish3/glassfish/bin/asadmin start-domain master-indexer-domain && /opt/glassfish3/glassfish/bin/asadmin --port 8448 --user admin --passwordfile /opt/gfpass enable-secure-admin
#-----END-----#

COPY startAll.sh /opt/
RUN  chmod a+x /opt/startAll.sh

# Expose the PostgreSQL port
EXPOSE 8048 8080 8081 8448

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/var/lib/pgsql/data"]

VOLUME  ["/opt/glassfish3"]

# Remove proxies at the end
#ENV http_proxy=""
#ENV https_proxy=""

# Set the default command to run when starting the container
CMD ["/opt/startAll.sh"]
