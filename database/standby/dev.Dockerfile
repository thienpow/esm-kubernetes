FROM postgres:13-alpine


COPY --chown=70:70 --chmod=600 ./dev-server.key /var/lib/postgresql/server.key
COPY --chown=70:70 --chmod=600 ./dev-server.crt /var/lib/postgresql/server.crt

COPY --chown=70:70 --chmod=600 ./ca.crt /var/lib/postgresql/ca.crt
COPY --chown=70:70 --chmod=600 ./ca.crl /var/lib/postgresql/ca.crl

ENV GOSU_VERSION 1.12

ADD ./gosu-amd64 /usr/bin/gosu
RUN chmod +x /usr/bin/gosu

RUN apk add --update iputils
RUN apk add --update htop

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]