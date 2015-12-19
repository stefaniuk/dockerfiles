#!/bin/bash
set -e
source /build/scripts/commons
set -x

# install Redis
$apt_get_install redis-server
sed "s/^daemonize yes/daemonize no/" -i /etc/redis/redis.conf
sed "s/^bind 127.0.0.1/bind 0.0.0.0/" -i /etc/redis/redis.conf
sed "s/^# unixsocket /unixsocket /" -i /etc/redis/redis.conf
sed "s/^# unixsocketperm 755/unixsocketperm 777/" -i /etc/redis/redis.conf
sed "/^logfile/d" -i /etc/redis/redis.conf
sed "s/^# syslog-enabled no/syslog-enabled yes/" -i /etc/redis/redis.conf
sed "s/^# syslog-ident redis/syslog-ident redis/" -i /etc/redis/redis.conf
sed "s/^# syslog-facility local0/syslog-facility local0/" -i /etc/redis/redis.conf
cp $FILES/etc/my_init.d/50-config-redis /etc/my_init.d/
mkdir /etc/service/redis
cp $FILES/etc/service/redis/run /etc/service/redis/

exit 0
