FROM postgres:13-alpine


COPY ./server.key /var/lib/postgresql/server.key
COPY ./server.crt /var/lib/postgresql/server.crt

COPY ./ca.crt /var/lib/postgresql/ca.crt
COPY ./ca.crl /var/lib/postgresql/ca.crl

RUN chown 70:70 /var/lib/postgresql/server.key 
RUN chmod 600 /var/lib/postgresql/server.key
RUN chown 70:70 /var/lib/postgresql/server.crt 
RUN chmod 600 /var/lib/postgresql/server.crt

RUN chown 70:70 /var/lib/postgresql/ca.crt
RUN chmod 600 /var/lib/postgresql/ca.crt
RUN chown 70:70 /var/lib/postgresql/ca.crl
RUN chmod 600 /var/lib/postgresql/ca.crl

COPY ./schema.sql /docker-entrypoint-initdb.d/
RUN chmod a+r /docker-entrypoint-initdb.d/*

COPY ./initial_data.sql /tmp/initial_data.sql
COPY ./setup.sh /docker-entrypoint-initdb.d/setup.sh
RUN chmod u+x /docker-entrypoint-initdb.d/setup.sh

ENTRYPOINT ["docker-entrypoint.sh"] 