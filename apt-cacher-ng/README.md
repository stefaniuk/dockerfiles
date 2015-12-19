docker-apt-cacher-ng
====================

The aim of the `apt-cacher-ng` project is to build an Apt-Cacher NG Docker container.

Installation
------------

    git clone https://github.com/stefaniuk/docker-apt-cacher-ng.git
    cd docker-apt-cacher-ng
    docker build -t stefaniuk/apt-cacher-ng --rm .

Quick Start
-----------

    docker create \
        --name="apt-cacher-ng" \
        --hostname="apt-cacher-ng" \
        --volume=/var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
        --publish=3142:3142 \
        stefaniuk/apt-cacher-ng
    docker start apt-cacher-ng
    docker exec -it apt-cacher-ng /bin/bash --login

Additional Information
----------------------

The `apt-cacher-ng` container can be tested by pointing web browser to http://localhost:3142/apt-cacher address to verify the service is running.

See
---

 * [sameersbn/docker-apt-cacher-ng](https://github.com/sameersbn/docker-apt-cacher-ng)
