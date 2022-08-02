# docker-postgres

A docker image to create extracts from postgres.

[![Production](https://github.com/anyways-open/docker-postgres/workflows/Production/badge.svg)](https://github.com/anyways-open/docker-postgres/actions?query=workflow%3AProduction)

Status: PRODUCTION :rocket:

## Backups

Backups are written to the volume `/var/lib/postgresql/dumps/` by executing 

  ```/usr/bin/pg_dump -U $PGDUMP_USER -p $PGDUMP_PORT -h $PGDUMP_HOST $PGDUMP_DB | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz```

The should be **stored on the host by mapping the volume**.

The container by default:
- keeps minutely backups for the last 2 hours.
- keeps daily backups for the last 7 days.
- keeps monthly backups for the last 365 days.
- keep all yearlies.

## Configuration

The container can be configure by using the following env vars:
- PGDUMP_USER: the user, usually `postgres`
- PGDUMP_PORT: the port, usually `5432`
- PGDUMP_HOST: the hostname of the container hosting the db.
- PGDUMP_DB: the name of the database to dump.
- PGPASSWORD: the password or secret containing the password.

Configure **one** of the following to control when backups are taken:
- PGDUMP_MINUTE: `true`, backups every minute.
- PGDUMP_HOUR: `true`, backups every hour.
- PGDUMP_DAY: `true`, backups every day.

The larger the database, the longer the interval. The next dump will already start even if the previous one hasn't yet finished.

An example configuration:

```
  identity-api-db:
    image: postgres:11.1
    hostname: identity-api-db
    volumes:
      - /var/services/core/identity/db:/var/lib/postgresql/data
    environment:
      POSTGRES_PASSWORD: _redacted_
  identity-api-db-dump:
    image: anywaysopen/postgres-dump:prod
    volumes:
      - /var/services/backups/identity-api-db-dump:/var/lib/postgresql/dumps
    environment:
      PGPASSWORD_FILE: /path/to/secret
      PGDUMP_USER: postgres
      PGDUMP_PORT: 5432
      PGDUMP_HOST: identity-api-db
      PGDUMP_DB: users
      PGDUMP_HOUR: 'true'
```

## Restore

Restoring a backup into an **empty** running docker container can be done as follows:

   `cat db_dump_25-09-2020_21_47_16.sql | docker exec -i container-name psql -U postgres db-name`
   
   
