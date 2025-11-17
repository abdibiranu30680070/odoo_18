FROM odoo:18

USER root
RUN apt-get update && apt-get install -y git python3-dev build-essential gettext && rm -rf /var/lib/apt/lists/*

USER odoo
ADD ./custom-addons /mnt/custom-addons

# Copy and process the config template
COPY odoo.conf /etc/odoo/odoo.conf.template
RUN envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
