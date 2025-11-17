FROM odoo:18

USER root
RUN apt-get update && apt-get install -y git python3-dev build-essential && rm -rf /var/lib/apt/lists/*

USER odoo
ADD ./custom-addons /mnt/custom-addons

# Create a startup script that waits for the database
COPY start-odoo.sh /start-odoo.sh
RUN chmod +x /start-odoo.sh

CMD ["/start-odoo.sh"]
