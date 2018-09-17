#!/usr/bin/env bash
#是否强制覆盖已有nginx配置文件
force_coverage=$1
#获取当前路径
script_path=$(cd `dirname $0`; pwd);
document_root=${script_path}/public;
#获取项目名
domain=$(ls ${script_path}|grep -E '.*\.conf'|sed -r 's/\.conf//')

#获取nginx服务
nginx_server=$(which nginx)
# 获取nginx 配置文件路径
nginx_vhost_dir=`sudo $nginx_server -T 2>/dev/null|grep -E 'include.*\*.conf'  |awk '{print $NF}'|xargs dirname`

if [ -z "${nginx_vhost_dir}" ]; then
    echo "nginx config has error ,please use $nginx_server -T see what happen."
    exit 1;
fi
# nginx配置文件名
vhost_conf_file=${nginx_vhost_dir}/${domain}.conf

#复制nginx配置文件
if [ -z ${force_coverage} ] && [ -f  "${vhost_conf_file}" ];then
    echo "nginx config file already exists";
    exit 0;
fi

sudo cp ${script_path}/${domain}.conf ${vhost_conf_file}
#替换模板变量
sudo sed -i "s#{document_root}#${document_root}#g" ${vhost_conf_file}
sudo sed -i "s#{domain}#${domain}#g" ${vhost_conf_file}

#测试nginx
sudo ${nginx_server} -t

if [ "0" != "$?" ]; then
    echo "nginx config has error ,need manual config it"
    exit 1;
fi

#重启nginx
sudo ${nginx_server} -s reload;


