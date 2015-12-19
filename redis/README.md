docker-redis
============

The aim of the `docker-redis` project is to build a Redis Docker container.

Installation
------------

    git clone https://github.com/stefaniuk/docker-redis.git
    cd docker-redis
    docker build -t stefaniuk/redis --rm .

Quick Start
-----------

    docker create \
        --name="redis" \
        --hostname="redis" \
        --volume=/var/lib/redis:/var/lib/redis \
        --publish=6379:6379 \
        stefaniuk/redis
    docker start redis
    docker exec -it redis /bin/bash --login

Additional Information
----------------------

You can login to the Redis interactive terminal

    docker exec -it redis \
        redis-cli

TODO
----

 * Implement startup configuration lock mechanism

See
---

 * [sameersbn/docker-redis](https://github.com/sameersbn/docker-redis)
 * [docker-library/redis](https://github.com/docker-library/redis)
