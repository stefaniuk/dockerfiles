#!/bin/bash
set -e
source /build/scripts/commons
set -x

# install init process
cp $FILES/sbin/my_init /sbin/
mkdir -p /etc/my_init.d
touch /etc/container_environment.sh
touch /etc/container_environment.json
groupadd -g 8377 docker_env
chown :docker_env /etc/container_environment.sh /etc/container_environment.json
chmod 640 /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/

# install a syslog stuff
$apt_get_install syslog-ng-core logrotate
# replace the system() source because inside Docker we can't access /proc/kmsg
sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf
cp $FILES/etc/my_init.d/01-syslog-forwarder /etc/my_init.d/
cp $FILES/etc/my_init.d/02-syslog-ng /etc/my_init.d/
cp $FILES/etc/logrotate.d/syslog-ng /etc/logrotate.d/
mkdir -p /var/lib/syslog-ng
cp $FILES/etc/default/syslog-ng /etc/default/
touch /var/log/syslog
chmod u=rw,g=r,o= /var/log/syslog

# install runit
$apt_get_install runit

# install the SSH server
$apt_get_install openssh-server
mkdir /var/run/sshd
mkdir /etc/service/sshd
touch /etc/service/sshd/down
cp $FILES/etc/service/sshd/run /etc/service/sshd/
cp $FILES/etc/ssh/sshd_config /etc/ssh/
cp $FILES/etc/my_init.d/10-regenerate-ssh-host-keys /etc/my_init.d/

# install default SSH key
mkdir -p /root/.ssh
chmod 700 /root/.ssh
chown root:root /root/.ssh
cp $FILES/etc/insecure_key* /etc
chmod 644 /etc/insecure_key*
chown root:root /etc/insecure_key*
cp $FILES/usr/sbin/enable_insecure_key /usr/sbin/

# install cron daemon
$apt_get_install cron
mkdir /etc/service/cron
chmod 600 /etc/crontab
cp $FILES/etc/service/cron/run /etc/service/cron/
rm -f /etc/cron.daily/standard

# this tool runs a command as another user and sets $HOME
cp $FILES/sbin/setuser /sbin/

# install often used tools
$apt_get_install \
    curl wget \
    unzip \
    vim mc \
    heirloom-mailx

# install configuration script
cp $FILES/etc/my_init.d/00-system-config /etc/my_init.d/

# install dotfiles
wget https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -O - | /bin/bash -s -- \
    --virtualised --minimal \
    --prepare --install --config

exit 0
