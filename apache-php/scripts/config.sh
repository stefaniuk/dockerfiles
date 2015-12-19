#!/bin/bash
set -e
source /build/scripts/commons
set -x

# temporarily disable dpkg fsync to make building faster
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

# set APT proxy
[ -n "$BUILD_APT_PROXY" ] && echo "Acquire::http { Proxy \"$BUILD_APT_PROXY\"; };" > /etc/apt/apt.conf.d/00-docker-build-proxy
# upgrade the system
$apt_get_update
$apt_get_upgrade

exit 0
