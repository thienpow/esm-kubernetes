FROM ubuntu:20.04

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

COPY ./gloader /usr/local/bin/gloader
RUN chmod u+x /usr/local/bin/gloader

CMD ["/usr/local/bin/gloader"]