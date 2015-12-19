#!/bin/bash
set -e
source /build/scripts/commons
set -x

# install PostgreSQL
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list
$apt_get_update
$apt_get_install \
    postgresql-${POSTGRESQL_VER} \
    postgresql-client-${POSTGRESQL_VER} \
    postgresql-contrib-${POSTGRESQL_VER}
cp $FILES/etc/my_init.d/50-config-postgresql /etc/my_init.d/
mkdir /etc/service/postgresql
cp $FILES/etc/service/postgresql/run /etc/service/postgresql/

exit 0
