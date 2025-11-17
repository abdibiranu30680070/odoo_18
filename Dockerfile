FROM odoo:18

USER root
RUN apt-get update && apt-get install -y git python3-dev build-essential && rm -rf /var/lib/apt/lists/*

USER odoo
ADD ./custom-addons /mnt/custom-addons

CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
