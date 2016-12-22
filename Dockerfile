FROM opensuse

# glassfish installation
RUN zypper -n in \
  java-1_7_0-openjdk \
  java-1_7_0-openjdk-devel \
  wget \
  unzip

RUN wget -q --no-cookies --no-check-certificate "http://download.java.net/glassfish/3.1.2.2/release/glassfish-3.1.2.2-unix.sh" -O /tmp/glassfish-3.1.2.2-unix.sh
RUN wget -q --no-cookies --no-check-certificate "https://raw.githubusercontent.com/reap/docker-glassfish3/master/glassfish-3.1.2.2-silent-installation-answers" -O /tmp/glassfish-3.1.2.2-silent-installation-answers
RUN sh /tmp/glassfish-3.1.2.2-unix.sh -s -a /tmp/glassfish-3.1.2.2-silent-installation-answers
RUN mkdir /etc/container_environment
RUN echo /opt/glassfish3 > /etc/container_environment/GLASSFISH_HOME
RUN echo /opt/glassfish3 > /etc/container_environment/GLASSFISH_HOME

ENV GLASSFISH_HOME=/opt/glassfish3

RUN wget -q --no-cookies --no-check-certificate "http://jdbc.postgresql.org/download/postgresql-9.3-1102.jdbc4.jar" -O /opt/glassfish3/glassfish/lib/postgresql-9.1-903.jdbc4.jar

ADD create_domain.sh glassfish.passwords ./

RUN chmod +x /*.sh
CMD sh create-domain.sh

ENV DB_INTERPRETER=psql
ENV JAVA_HOME=/usr
#-----END-----#

# postgresql94 installation
RUN zypper addrepo -t YUM http://packages.2ndquadrant.com/postgresql-z-suse/zypper/sles-11sp3-s390x pg
RUN zypper -n --no-gpg-checks refresh
RUN zypper -n in postgresql94-server \
    sudo

USER postgres

ENV PGDATA=/var/lib/pgsql/database

RUN mkdir $PGDATA && \
    initdb

RUN pg_ctl start && \
    sleep 2 && \
    psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

COPY pg_hba.conf postgresql.conf PGDATA/
#-----END-----#

USER root

# unpack oscm installation
ADD oscm* /opt/
RUN unzip /opt/oscm-install-pack.zip -d /opt/oscm-install-pack && \
    rm /opt/oscm-install-pack.zip
#-----END-----#

# unpack apache
ADD apache* /opt/
RUN unzip /opt/apache-ant-1.9.6-bin.zip -d /opt/ && \
    rm /opt/apache-ant-1.9.6-bin.zip
RUN chmod -R 755 /opt/apache-ant-1.9.6/
#-----END-----#

# unpack james
ADD james-2.3.2.1.zip /opt/
RUN unzip /opt/james-2.3.2.1.zip -d /opt/ && \
    rm /opt/james-2.3.2.1.zip
#-----END-----#

# configure db
ADD configsettings.properties /opt/oscm-install-pack/databases/bes_db/
RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 2 &&\
	  /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml setParam

RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 2 &&\
	  /opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml CREATE.dbsAndUsers

ADD playground.sql /opt/
RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 3 &&\
    sudo -u postgres PGPASSWORD=postgres psql -Upostgres -f /opt/playground.sql bss
RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 3 &&\
  	/opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml UPDATE.dbSchema
RUN sudo -u postgres pg_ctl start -D $PGDATA && sleep 3 &&\
  	/opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-db.xml UPDATE.configSettings

ADD glassfish_bes.properties /opt/oscm-install-pack/domains/bes_domain/glassfish.properties
ADD glassfish_mid.properties /opt/oscm-install-pack/domains/indexer_domain/glassfish.properties

RUN mkdir /opt/indexdir && \
	chmod a+w /opt/indexdir && \
	sudo -u postgres pg_ctl start -D $PGDATA && sleep 3 &&\
	/opt/apache-ant-1.9.6/bin/ant -f /opt/oscm-install-pack/install/build-glassfish.xml SETUP
	#sudo -u postgres pg_ctl stop -D $PGDATA

ADD gfpass /opt/
ADD oscm-integrationtests-mockproduct.war /opt/
ADD birt.war /opt/
RUN /opt/glassfish3/glassfish/bin/asadmin start-domain bes-domain && /opt/glassfish3/glassfish/bin/asadmin --port 8048 --user admin --passwordfile /opt/gfpass enable-secure-admin && \
/opt/glassfish3/glassfish/bin/asadmin deploy /opt/oscm-integrationtests-mockproduct.war --port 8048 --user admin --passwordfile /opt/gfpass && \
/opt/glassfish3/glassfish/bin/asadmin deploy /opt/birt.war --port 8048 --user admin --passwordfile /opt/gfpass
RUN /opt/glassfish3/glassfish/bin/asadmin start-domain master-indexer-domain && /opt/glassfish3/glassfish/bin/asadmin --port 8448 --user admin --passwordfile /opt/gfpass enable-secure-admin
ADD startAll.sh /opt/
RUN  chmod a+x /opt/startAll.sh

RUN  chmod a+x /opt/james-2.3.2.1/bin/*.sh

# Expose the PostgreSQL port
EXPOSE 8048 8080 8081 8448

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Remove proxies at the end
#ENV http_proxy=""
#ENV https_proxy=""

# Set the default command to run when starting the container
CMD ["/opt/startAll.sh"]
