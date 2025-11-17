#!/bin/bash
set -e

# Wait for PostgreSQL to be ready using python3
python3 /usr/local/bin/wait-for-psql.py \
    --db_host=$DATABASE_HOST \
    --db_port=$DATABASE_PORT \
    --db_user=$DATABASE_USER \
    --db_password=$DATABASE_PASSWORD

# Start Odoo
exec odoo -c /etc/odoo/odoo.conf "$@"
