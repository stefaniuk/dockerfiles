docker-openldap
===============

The aim of the `docker-openldap` project is to build an OpenLDAP Docker container.

Installation
------------

    git clone https://github.com/stefaniuk/docker-openldap.git
    cd docker-openldap
    docker build -t stefaniuk/openldap --rm .

Quick Start
-----------

    sudo mkdir -p /var/lib/docker/mount
    docker create \
        --name="openldap" \
        --hostname="openldap" \
        --env="SLAPD_PASSWORD=secret" \
        --env="SLAPD_ORGANIZATION=Example" \
        --env="SLAPD_DOMAIN=example.com" \
        --volume=/var/lib/docker/mount/openldap:/var/lib/ldap \
        --publish=389:389 \
        stefaniuk/openldap
    docker start openldap
    docker exec -it openldap /bin/bash --login

Additional Information
----------------------

You can login to the OpenLDAP instance using the following user name, domain component parts and password respectively: `cn=admin,dc=example,dc=com`, `secret`.

TODO
----

 * Implement startup configuration lock mechanism
 * Configure OpenLDAP log messages format and level

See
---

 * [dinkel/docker-openldap](https://github.com/dinkel/docker-openldap)
