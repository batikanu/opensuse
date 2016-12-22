#!/bin/bash
sudo -u postgres pg_ctl start -D /var/lib/pgsql/database && sleep 3
/opt/glassfish3/bin/asadmin start-domain master-indexer-domain &
/opt/glassfish3/bin/asadmin start-domain bes-domain &
/opt/james-2.3.2.1/bin/run.sh &
read -p "Press [Enter] key to stop container. Press <ctrl><p> <ctrl><q> to switch back to docker"
