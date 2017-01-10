FROM opensuse

# postgresql94 installation
RUN zypper addrepo -t YUM http://packages.2ndquadrant.com/postgresql-z-suse/zypper/sles-11sp3-s390x pg
RUN zypper -n --no-gpg-checks refresh
RUN zypper -n in postgresql94-server \
    sudo

USER postgres

ENV PGDATA=/var/lib/pgsql/database

RUN mkdir $PGDATA

RUN initdb && \
    pg_ctl start && \
    sleep 2 && \
    psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

COPY database/ /var/lib/pgsql/backup

USER root
COPY start.sh /opt/
RUN  chmod a+x /opt/start.sh


# Expose the PostgreSQL port
EXPOSE 8048 8080 8081 8448

CMD ["/opt/start.sh"]
#-----END-----#
