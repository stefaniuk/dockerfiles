#!/bin/bash

tag=$1
apt_proxy=$2

# check if build-time variables need to be set
should_set_variables=
[ -n "$apt_proxy" ] && \
    should_set_variables="yes"

function set_variable {
    [ -n "$1" ] && [ -n "$2" ] && \
        cat Dockerfile | \
        sed s/\${$1}/$( echo $2 | sed s/\\//\\\\\\//g )/g \
        > Dockerfile
}

# backup Dockerfile and set variables
if [ -n "$should_set_variables" ]; then
    cp Dockerfile Dockerfile.bak
    set_variable "BUILD_APT_PROXY" "$apt_proxy"
fi

# build image
docker build --tag=$tag --rm .

# restore Dockerfile
if [ -n "$should_set_variables" ]; then
    mv Dockerfile.bak Dockerfile
fi

exit 0
