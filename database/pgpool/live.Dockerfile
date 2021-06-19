FROM thienpow/pgpool:4.2.3


COPY --chown=70:70 --chmod=600 ./live-server.key /certs/server.key
COPY --chown=70:70 --chmod=600 ./live-server.crt /certs/server.crt

COPY --chown=70:70 --chmod=600 ./ca.crt /certs/ca.crt
COPY --chown=70:70 --chmod=600 ./ca.crl /certs/ca.crl
