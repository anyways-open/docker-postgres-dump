#!/usr/bin/env bash
pg_dumpall -c -U postgres | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz