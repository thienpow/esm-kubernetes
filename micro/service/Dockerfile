FROM ubuntu:20.04

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

COPY ./esmserver /usr/local/bin/esmserver
RUN chmod u+x /usr/local/bin/esmserver

CMD ["/usr/local/bin/esmserver"]