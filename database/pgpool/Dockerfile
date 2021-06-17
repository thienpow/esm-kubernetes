FROM pgpool/pgpool:latest

COPY --chown=70:70 --chmod=600 ./server.key /certs/server.key
COPY --chown=70:70 --chmod=600 ./server.crt /certs/server.crt

COPY --chown=70:70 --chmod=600 ./ca.crt /certs/ca.crt
COPY --chown=70:70 --chmod=600 ./ca.crl /certs/ca.crl
