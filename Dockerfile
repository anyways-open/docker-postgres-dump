FROM postgres:13

LABEL maintainer="ANYWAYS BV"

VOLUME /var/lib/postgresql/dumps

# install cron.
RUN apt-get update
RUN apt-get install -y cron nano
ADD docker-crontab /
RUN crontab /docker-crontab

COPY *.sh /
RUN chmod 0755 /*.sh

ENTRYPOINT (printenv > /etc/environment && cron -f)