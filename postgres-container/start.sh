#!/bin/bash

cp -rf /var/lib/pgsql/backup/* /var/lib/pgsql/database/
chown -R postgres:postgres /var/lib/pgsql/database
rm -rf /var/lib/pgsql/backup
sudo -u postgres postgres -D /var/lib/pgsql/database
