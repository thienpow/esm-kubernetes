#!/bin/sh

if [ ! -s "$PGDATA/PG_VERSION" ]; then
echo "*:*:*:$PG_REP_USER:$PG_REP_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass

#until ping -c 1 -W 1 ${PG_MASTER_HOST:?missing environment variable. PG_MASTER_HOST must be set}
#    do
#        echo "Waiting for master to ping..."
#        sleep 1s
#done
until pg_basebackup -h ${PG_MASTER_HOST} -p ${PG_MASTER_PORT} -D ${PGDATA} -U ${PG_REP_USER} -vP -W
    do
        echo "Waiting for master to connect..."
        sleep 1s
done

echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
echo "hostssl all all all cert clientcert=verify-ca" >> "$PGDATA/pg_hba.conf"
touch "$PGDATA/standby.signal"
pg_ctl -D ${PGDATA} start

chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi

sed -i 's/wal_level = replica/g' ${PGDATA}/postgresql.conf 

exec "$@"