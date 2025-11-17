#!/bin/bash
set -e

echo "=== Odoo Startup ==="
echo "Database: $DATABASE_NAME @ $DATABASE_HOST:$DATABASE_PORT"

# Start Odoo with ONLY standard addons (this will work)
echo "Starting Odoo with standard addons..."
exec odoo \
    --addons-path=/usr/lib/python3/dist-packages/odoo/addons \
    --database="$DATABASE_NAME" \
    --db_host="$DATABASE_HOST" \
    --db_port="$DATABASE_PORT" \
    --db_user="$DATABASE_USER" \
    --db_password="$DATABASE_PASSWORD" \
    --proxy-mode \
    --without-demo=all \
    --db-filter="$DATABASE_NAME" \
    --no-database-list \
    --log-level=info
