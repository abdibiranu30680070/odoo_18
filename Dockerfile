FROM odoo:18

USER root

# Install dependencies
RUN apt-get update && apt-get install -y git python3-dev build-essential postgresql-client && rm -rf /var/lib/apt/lists/*

# Create custom-addons directory with proper permissions
RUN mkdir -p /mnt/custom-addons && chown odoo:odoo /mnt/custom-addons

# Copy custom addons
COPY ./custom-addons /mnt/custom-addons/

# Fix permissions for custom addons
RUN chown -R odoo:odoo /mnt/custom-addons && chmod -R 755 /mnt/custom-addons

# Copy startup script
COPY start-odoo.sh /start-odoo.sh
RUN chmod +x /start-odoo.sh

USER odoo

CMD ["/start-odoo.sh"]
