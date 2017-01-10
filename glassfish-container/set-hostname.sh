#/bin/bash

function change() {
  sed -i "/<jdbc-connection-pool validation-table-name=\"VERSION\" datasource-classname=\"org.postgresql.xa.PGXADataSource\" res-type=\"javax.sql.XADataSource\" description=\"Connection pool for BSS\" name=\"BSSPool\" is-connection-validation-required=\"true\">/,/<\/jdbc-connection-pool>/ s/<property name=\"serverName\" value=\"localhost\"><\/property>/<property name=\"serverName\" value=\"$2\"><\/property>/" $1
}

change /opt/glassfish3/glassfish/domains/bes-domain/config/domain.xml $POSTGRES_HOSTNAME
change /opt/glassfish3/glassfish/domains/master-indexer-domain/config/domain.xml $POSTGRES_HOSTNAME
