#/bin/bash

sed "/<jdbc-connection-pool validation-table-name=\"VERSION\" datasource-classname=\"org.postgresql.xa.PGXADataSource\" res-type=\"javax.sql.XADataSource\" description=\"Connection pool for BSS\" name=\"BSSPool\" is-connection-validation-required=\"true\">/,/<\/jdbc-connection-pool>/ s/<property name=\"serverName\" value=\"localhost\"><\/property>/<property name=\"serverName\" value=\"$1\"><\/property>/" $2 > $2
