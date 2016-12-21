FROM opensuse

# glassfish installation
RUN zypper -n in \
  java-1_7_0-openjdk \
  java-1_7_0-openjdk-devel \
  wget

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


# postgresql94 installation
#RUN zypper addrepo -t YUM http://packages.2ndquadrant.com/postgresql-z-suse/zypper/sles-11sp3-s390x pg
#RUN zypper -n --no-gpg-checks refresh
#RUN zypper -n install postgresql94-server
