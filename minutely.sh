#!/bin/bash

export PGPASSWORD="$(< "$PGPASSWORD_FILE")"

case $PGDUMP_MINUTE in
    "true")
        /usr/bin/pg_dump -U $PGDUMP_USER -p $PGDUMP_PORT -h $PGDUMP_HOST $PGDUMP_DB | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_00`.sql.gz
        ;;
esac
