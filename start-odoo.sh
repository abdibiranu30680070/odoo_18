#!/bin/bash
set -e

echo "=== Testing Custom Module ==="

# Check if module exists in extra-addons
if [ -f "/mnt/extra-addons/sale_order_invoice_style/__manifest__.py" ]; then
    echo "✅ Custom module found in /mnt/extra-addons"
    echo "Module structure:"
    ls -la /mnt/extra-addons/sale_order_invoice_style/
else
    echo "❌ Custom module not found in /mnt/extra-addons"
    echo "Available in /mnt/extra-addons:"
    ls -la /mnt/extra-addons/
fi

echo "Starting Odoo..."
exec odoo \
    --addons-path=/usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons \
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
