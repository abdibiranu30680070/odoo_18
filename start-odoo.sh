#!/bin/bash
set -e

echo "=== Checking Database Connection ==="
echo "Host: $DATABASE_HOST"
echo "Port: $DATABASE_PORT"
echo "User: $DATABASE_USER"
echo "Database: $DATABASE_NAME"

# Test basic connection first
echo "Testing database connection..."
if PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -d "postgres" -c "SELECT 1;" 2>/dev/null; then
    echo "✅ Connected to PostgreSQL server"
    
    # Check if our specific database exists
    if PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -d "postgres" -t -c "SELECT 1 FROM pg_database WHERE datname='$DATABASE_NAME';" | grep -q 1; then
        echo "✅ Database $DATABASE_NAME exists"
        
        # Test connection to the specific database
        if PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -d "$DATABASE_NAME" -c "SELECT 1;" 2>/dev/null; then
            echo "✅ Successfully connected to database $DATABASE_NAME"
        else
            echo "❌ Cannot connect to database $DATABASE_NAME - it may be corrupted"
            exit 1
        fi
    else
        echo "❌ Database $DATABASE_NAME does not exist"
        echo "Creating database $DATABASE_NAME..."
        PGPASSWORD=$DATABASE_PASSWORD psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USER" -d "postgres" -c "CREATE DATABASE $DATABASE_NAME;"
    fi
else
    echo "❌ Cannot connect to PostgreSQL server at $DATABASE_HOST:$DATABASE_PORT"
    echo "Please check your database credentials and network connectivity"
    exit 1
fi

echo "=== Starting Odoo ==="
exec odoo -c /etc/odoo/odoo.conf "$@"
