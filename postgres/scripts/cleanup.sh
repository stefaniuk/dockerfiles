#!/bin/bash
set -e
source /build/scripts/commons
set -x

$apt_get_remove
$apt_get_clean

rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
rm -f /etc/apt/apt.conf.d/00-docker-build-proxy
rm -f /etc/ssh/ssh_host_*

rm -rf /var/lib/postgresql

exit 0
