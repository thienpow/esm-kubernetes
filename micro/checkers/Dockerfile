FROM ubuntu:20.04

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

COPY ./checker_current_game /usr/local/bin/checker_current_game
RUN chmod u+x /usr/local/bin/checker_current_game

COPY ./checker_leaderboard /usr/local/bin/checker_leaderboard
RUN chmod u+x /usr/local/bin/checker_leaderboard

COPY ./checker_subscriber /usr/local/bin/checker_subscriber
RUN chmod u+x /usr/local/bin/checker_subscriber

COPY ./checker_unclaim /usr/local/bin/checker_unclaim
RUN chmod u+x /usr/local/bin/checker_unclaim

COPY ./start.sh /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start

CMD ["/usr/local/bin/start"]