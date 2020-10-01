# docker-postgres

A custom docker image for postgres with built-in data dumps.

[![Production](https://github.com/anyways-open/docker-postgres/workflows/Production/badge.svg)](https://github.com/anyways-open/docker-postgres/actions?query=workflow%3AProduction)

Status: PRODUCTION

## Backups

Backups are generate every minute to the volume `/var/lib/postgresql/dumps/` by executing 

  ```pg_dumpall -c -U postgres | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz```

The should be **stored on the host by mapping the volume**.

The container by default:
- keeps minutely backups for the last 2 hours.
- keeps hourly backups for the past 7 days.
- keeps daily backups for the last 30 days.
- keeps monthly backups for the last 365 days.
- keep all yearlies.

## Restore

Restoring a backup into an **empty** running docker container can be done as follows:

   `cat db_dump_25-09-2020_21_47_16.sql | docker exec -i container-name psql -U postgres`
   
   
