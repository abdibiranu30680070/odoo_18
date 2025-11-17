#!/bin/bash
set -e

echo "=== Odoo Startup Diagnostic ==="
echo "Database: $DATABASE_NAME @ $DATABASE_HOST:$DATABASE_PORT"

# Check if custom-addons directory exists and what's in it
echo "Checking /mnt/custom-addons directory..."
if [ -d "/mnt/custom-addons" ]; then
    echo "✅ Directory exists"
    echo "Contents of /mnt/custom-addons:"
    ls -la /mnt/custom-addons/
    
    # Check if there are any Odoo modules
    echo "Looking for Odoo modules..."
    find /mnt/custom-addons -name "__manifest__.py" | head -10
else
    echo "❌ Directory /mnt/custom-addons does not exist"
    exit 1
fi

# For now, use only standard addons to get Odoo running
echo "Starting Odoo with standard addons only..."
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
