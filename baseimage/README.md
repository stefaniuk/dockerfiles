docker-baseimage
================

The aim of the `baseimage` project is to build a minimal Ubuntu image that is configured to initialise system correctly.

Installation
------------

    git clone https://github.com/stefaniuk/docker-baseimage.git
    cd docker-baseimage
    docker build -t stefaniuk/baseimage --rm .

Quick Start
-----------

    docker create \
        --name="baseimage" \
        --hostname="baseimage" \
        stefaniuk/baseimage
    docker start baseimage
    docker exec -it baseimage /bin/bash --login

Additional Information
----------------------

#### Build-time environment variables

Usage example:

    make build APT_PROXY="http://apt-cacher-ng:3142"

Full list of variables:

 - **APT_PROXY**: URL address of APT proxy server

#### Create-time environment variables

Usage example:

    docker create \
        --env="APT_PROXY=http://apt-cacher-ng:3142" \
        stefaniuk/baseimage

Full list of variables:

 - **APT_PROXY**: URL address of APT proxy server

TODO
----

 * Reduce size of installed `dotfiles`
 * Explore [ONBUILD](https://docs.docker.com/reference/builder/) instruction
 * Configure Syslog log messages date/time format

See
---

 * [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker)
