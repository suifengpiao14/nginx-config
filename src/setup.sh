#!/bin/sh

if [ -e ./conf-nginx ];
then
    CONF_NGINX_EXISTS=1
else
    CONF_NGINX_EXISTS=0
fi

cp ./vendor/suifengpiao14/nginx-config/src/domain.conf ./domain.conf
cp ./vendor/suifengpiao14/nginx-config/src/config_nginx.sh ./config_nginx.sh
chmod +x ./config_nginx.sh

if [ "$CONF_NGINX_EXISTS" = 0 ];
then
    echo "auto config nginx script is installed!"
else
    echo "auto config nginx script is updated!"
fi