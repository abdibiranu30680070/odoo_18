FROM odoo:18

USER root
RUN apt-get update && apt-get install -y git python3-dev build-essential postgresql-client && rm -rf /var/lib/apt/lists/*

# Copy and set permissions while still as root
COPY start-odoo.sh /start-odoo.sh
RUN chmod +x /start-odoo.sh

# Add custom addons
ADD ./custom-addons /mnt/custom-addons

# Switch to odoo user for runtime
USER odoo

CMD ["/start-odoo.sh"]
