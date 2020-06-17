#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
rm /var/lib/apt/lists/* -vrf
apt-get -y update
apt-get -y install nginx
chmod -R 766 /etc/nginx/nginx.conf
echo "stream { upstream postgresql { server $1.postgres.database.azure.com:5432; } server { listen 5432; proxy_pass postgresql; } }" >> /etc/nginx/nginx.conf
chmod -R 644 /etc/nginx/nginx.conf
service nginx restart
update-rc.d nginx defaults