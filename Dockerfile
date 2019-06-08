FROM odoo:9.0

USER root
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y git wget gcc python-dev libssl-dev libffi-dev make

##### 10) Installer wkhtml to pdf 0.12.1 !! (pas une autre) (sur une machine 64 bit avec un ubuntu 64bit 14.04)
# RUN apt-get install -y fontconfig  libfontconfig1 libxrender1 fontconfig-config libjpeg-turbo8-dev && \
#     wget --quiet https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.trusty_amd64.deb && \
#     dpkg -i wkhtmltox_0.12.5-1.trusty_amd64.deb && \
#     ln -s /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage && \
#     ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

RUN mkdir -p /app/extra-addons &&  chown odoo /app/extra-addons

USER odoo
ADD Obeesdoo /app/extra-addons/Obeesdoo
ADD vertical-cooperative /app/extra-addons/vertical-cooperative
ADD	addons /app/extra-addons/addons
ADD procurement-addons /app/extra-addons/procurement-addons
ADD l10n-belgium /app/extra-addons/l10n-belgium
ADD mis-builder /app/extra-addons/mis-builder
ADD web /app/extra-addons/web
ADD server-tools /app/extra-addons/server-tools
ADD reporting-engine /app/extra-addons/reporting-engine

USER root
RUN pip install --upgrade  setuptools enum
RUN pip install -r /app/extra-addons/reporting-engine/requirements.txt
RUN pip install -r /app/extra-addons/server-tools/requirements.txt
RUN pip install -r /app/extra-addons/Obeesdoo/requirements.txt

USER odoo

# COPY example_odoo.conf /etc/odoo/openerp-server.conf
