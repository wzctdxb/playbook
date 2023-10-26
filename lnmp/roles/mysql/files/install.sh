#!/bin/bash
# install mysql


#create user
groupadd -r -g 306 mysql
useradd -r -M -s /sbin/nologin -g 306 -u 306 mysql

#unzip
tar -xf /usr/src/mysql-5.7.39-linux-glibc2.12-x86_64.tar.gz -C /usr/local/

#install
cd /usr/local
ln -sv mysql-5.7.39-linux-glibc2.12-x86_64/ mysql
chown -R mysql:mysql /usr/local/mysql
echo 'export PATH=/usr/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
source /etc/profile.d/mysql.sh
mkdir /opt/data
chown -R mysql.mysql /opt/data/
/usr/local/mysql/bin/mysqld --initialize --user=mysql --datadir=/opt/data/  &> /usr/local/mysql/sqlpass
ln -sv /usr/local/mysql/include/ /usr/local/include/mysql
echo '/usr/local/mysql/lib' > /etc/ld.so.conf.d/mysql.conf
ldconfig
echo 'MANPATH /usr/local/mysql/man' >> /etc/man.config

cat > /etc/my.cnf <<EOF
[mysqld]
basedir = /usr/local/mysql
datadir = /opt/data
socket = /tmp/mysql.sock
port = 3306
pid-file = /opt/data/mysql.pid
user = mysql
skip-name-resolve
EOF

cp -a /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -ri 's#^(basedir=).*#\1/usr/local/mysql#g' /etc/init.d/mysqld
sed -ri 's#^(datadir=).*#\1/opt/data#g' /etc/init.d/mysqld
ln -s /usr/lib64/libtinfo.so.6 /usr/lib64/libtinfo.so.5
ln -s /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5
touch /usr/local/mysql/ok
cd
source /etc/profile.d/mysql.sh
