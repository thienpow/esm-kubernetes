FROM postgres:13-alpine


COPY --chown=70:70 --chmod=600 ./live-server.key /var/lib/postgresql/server.key
COPY --chown=70:70 --chmod=600 ./live-server.crt /var/lib/postgresql/server.crt

COPY --chown=70:70 --chmod=600 ./live-ca.crt /var/lib/postgresql/ca.crt
COPY --chown=70:70 --chmod=600 ./live-ca.crl /var/lib/postgresql/ca.crl

COPY ./schema.sql /docker-entrypoint-initdb.d/
RUN chmod a+r /docker-entrypoint-initdb.d/*

COPY ./initial_data.sql /tmp/initial_data.sql
COPY ./setup.sh /docker-entrypoint-initdb.d/setup.sh
RUN chmod u+x /docker-entrypoint-initdb.d/setup.sh

ENTRYPOINT ["docker-entrypoint.sh"] 