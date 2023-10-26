#!/bin/bash

cd /usr/src/nginx-1.22.1
./configure \
--prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-debug \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log
make -j $(grep 'processor' /proc/cpuinfo | wc -l)
make install
echo 'export PATH=/usr/local/nginx/sbin:$PATH' > /etc/profile.d/nginx.sh
source /etc/profile.d/nginx.sh
