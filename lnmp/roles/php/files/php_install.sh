#!/bin/bash
yum -y install http://mirror.centos.org/centos/8-stream/PowerTools/x86_64/os/Packages/oniguruma-devel-6.8.2-2.el8.x86_64.rpm
cd /usr/src
tar xf php-8.2.9.tar.gz
cd  php-8.2.9
./configure --prefix=/usr/local/php8 \
--with-config-file-path=/etc \
--enable-fpm \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-soap \
--with-openssl \
--enable-bcmath \
--with-iconv \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif \
--enable-ftp \
--enable-gd \
--with-jpeg \
--with-zlib-dir \
--with-freetype \
--with-gettext \
--enable-mbstring \
--enable-pdo \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-readline \
--enable-shmop \
--enable-simplexml \
--enable-sockets \
--with-zip \
--enable-mysqlnd-compression-support \
--with-pear \
--enable-pcntl \
--enable-posix
make -j4 $(cat /proc/cpuinfo |grep processor|wc -l)
make install
echo 'export PATH=/usr/local/php8/bin:$PATH' > /etc/profile.d/php8.sh
source /etc/profile.d/php8.sh
cp php.ini-production /etc/php.ini
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/rc.d/init.d/php-fpm
cp /usr/local/php8/etc/php-fpm.conf.default /usr/local/php8/etc/php-fpm.conf
cp /usr/local/php8/etc/php-fpm.d/www.conf.default /usr/local/php8/etc/php-fpm.d/www.conf
