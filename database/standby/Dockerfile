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


ENV GOSU_VERSION 1.12

ADD ./gosu-amd64 /usr/bin/gosu
RUN chmod +x /usr/bin/gosu

RUN apk add --update iputils
RUN apk add --update htop

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
