#!/bin/bash
set -e

echo "=== Odoo Startup ==="
echo "Database: $DATABASE_NAME @ $DATABASE_HOST:$DATABASE_PORT"

# Check what addons directories exist
echo "Checking available addons directories..."
find / -name "*addons*" -type d 2>/dev/null | head -10

# Start Odoo with the correct addons path
exec odoo \
    --addons-path=/usr/lib/python3/dist-packages/odoo/addons,/custom-addons \
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
