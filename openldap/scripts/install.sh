#!/bin/bash
set -e
source /build/scripts/commons
set -x

# install OpenLDAP
$apt_get_install slapd ldap-utils
mkdir /etc/{ldap/modules,service/openldap}
cp $FILES/etc/ldap/modules/*.ldif /etc/ldap/modules/ 2> /dev/null || :
cp $FILES/etc/my_init.d/50-config-openldap /etc/my_init.d/
cp $FILES/etc/service/openldap/run /etc/service/openldap/

exit 0
