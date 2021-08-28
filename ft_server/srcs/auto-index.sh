#!/bin/bash

if grep "autoindex on;" /etc/nginx/sites-enabled/wordpress > /dev/null; then
    echo "AUTO INDEX: OFF"
    sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/wordpress
else
    echo "AUTO INDEX: ON"
    sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-available/wordpress
fi
nginx -s reload
