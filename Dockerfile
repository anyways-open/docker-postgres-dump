FROM postgres:11

LABEL maintainer="ANYWAYS BV"

VOLUME /var/lib/postgresql/dumps

# install cron.
RUN apt-get update
RUN apt-get install -y cron
ADD docker-crontab /
RUN crontab /docker-crontab

ENTRYPOINT docker-entrypoint.sh && cron -f
