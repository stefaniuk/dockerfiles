#!/bin/bash
set -e
source /build/scripts/commons
set -x

$apt_get_install apt-cacher-ng

sed "s/# ForeGround: 0/ForeGround: 1/" -i /etc/apt-cacher-ng/acng.conf
mkdir /etc/service/apt-cacher-ng
cp $FILES/etc/service/apt-cacher-ng/run /etc/service/apt-cacher-ng/

exit 0
