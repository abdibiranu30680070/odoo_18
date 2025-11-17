#!/bin/bash
set -e

echo "=== Odoo Startup ==="
echo "Database: $DATABASE_NAME @ $DATABASE_HOST:$DATABASE_PORT"

# First, initialize the database with base modules if not already initialized
echo "Checking if database needs initialization..."
if ! PGPASSWORD="$DATABASE_PASSWORD" psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -d "$DATABASE_NAME" -c "SELECT 1 FROM ir_module_module LIMIT 1;" > /dev/null 2>&1; then
    echo "Database not initialized. Installing base modules..."
    odoo \
        --addons-path=/usr/lib/python3/dist-packages/odoo/addons \
        --database="$DATABASE_NAME" \
        --db_host="$DATABASE_HOST" \
        --db_port="$DATABASE_PORT" \
        --db_user="$DATABASE_USER" \
        --db_password="$DATABASE_PASSWORD" \
        -i base \
        --stop-after-init \
        --without-demo=all
    echo "✅ Base modules installed successfully"
else
    echo "✅ Database already initialized"
fi

# Now start Odoo normally
echo "Starting Odoo server..."
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
