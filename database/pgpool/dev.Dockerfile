FROM thienpow/pgpool:4.2.3


COPY --chown=70:70 --chmod=600 ./dev-server.key /certs/server.key
COPY --chown=70:70 --chmod=600 ./dev-server.crt /certs/server.crt

COPY --chown=70:70 --chmod=600 ./dev-ca.crt /certs/ca.crt
COPY --chown=70:70 --chmod=600 ./dev-ca.crl /certs/ca.crl
