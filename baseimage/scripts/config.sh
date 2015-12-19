#!/bin/bash
set -e
source /build/scripts/commons
set -x

mkdir -p /etc/container_environment
chmod 700 /etc/container_environment

# temporarily disable dpkg fsync to make building faster
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

# prevent initramfs updates from trying to run boot loader
# SEE: https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# SEE: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
echo -n no > /etc/container_environment/INITRD

# fix some issues with APT packages
# SEE: https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# replace the 'ischroot' tool to make it always return true
# prevent initscripts updates from breaking /dev/shm
# SEE: https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# SEE: https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

# set APT proxy
[ -n "$BUILD_APT_PROXY" ] && echo "Acquire::http { Proxy \"$BUILD_APT_PROXY\"; };" > /etc/apt/apt.conf.d/00-docker-build-proxy
# enable universe and multiverse repositories then upgrade the system
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
$apt_get_update
$apt_get_upgrade

# install HTTPS support for APT
$apt_get_install apt-transport-https ca-certificates

# install add-apt-repository
$apt_get_install software-properties-common

# fix locale
$apt_get_install language-pack-en
locale-gen en_GB.UTF-8
update-locale LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8
echo -n en_GB.UTF-8 > /etc/container_environment/LANG
echo -n en_GB.UTF-8 > /etc/container_environment/LC_CTYPE

# fix timezone
echo "Europe/London" | tee /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

exit 0
