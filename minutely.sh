#!/bin/bash

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
# file_env() {
# 	local var="$1"
# 	local fileVar="${var}_FILE"
# 	local def="${2:-}"
# 	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
# 		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
# 		exit 1
# 	fi
# 	local val="$def"
# 	if [ "${!var:-}" ]; then
# 		val="${!var}"
# 	elif [ "${!fileVar:-}" ]; then
# 		val="$(< "${!fileVar}")"
# 	fi
# 	export "$var"="$val"
# 	unset "$fileVar"
# }

export PGPASSWORD="$(< "$PGPASSWORD_FILE")"

case $PGDUMP_MINUTE in
    "true")
        /usr/bin/pg_dump -U $PGDUMP_USER -p $PGDUMP_PORT -h $PGDUMP_HOST $PGDUMP_DB | gzip > /var/lib/postgresql/dumps/db_dump_`date +%d-%m-%Y"_"%H_%M_00`.sql.gz
        ;;
esac
