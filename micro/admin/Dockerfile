FROM ubuntu:20.04

COPY ./wwwloader /wwwloader
RUN chmod u+x /wwwloader

COPY ./www /www

COPY ./start.sh /start
RUN chmod u+x /start

CMD ["/start"]