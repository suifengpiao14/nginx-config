#!/bin/sh
# 第一个参数为项目路径,默认为当前目录，第二个参数为域名，默认为项目路径文件名
document_root=${1:-`pwd`}
domain=${2:-` basename $document_root`}


config_file="${domain}.conf";

if [ -e config_file ];
then
    CONF_NGINX_EXISTS=1
else
    CONF_NGINX_EXISTS=0
fi

cp ./vendor/suifengpiao14/nginx-config/src/domain.conf ${config_file}

#替换模板变量
sed -i "s#{document_root}#${document_root}#g" ${config_file}
sed -i "s#{domain}#${domain}#g" ${config_file}


if [ "$CONF_NGINX_EXISTS" = 0 ];
then
    echo "auto config nginx script is installed!"
else
    echo "auto config nginx script is updated!"
fi