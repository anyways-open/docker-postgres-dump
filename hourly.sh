#!/bin/bash

case $PGDUMP_HOUR in
    "true")
        /usr/bin/pg_dump -U $PGDUMP_USER -p $PGDUMP_PORT -h $PGDUMP_HOST $PGDUMP_DB | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz
        ;;
esac
