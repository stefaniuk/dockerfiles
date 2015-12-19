docker-postgresql
=================

The aim of the `docker-postgresql` project is to build a PostgreSQL Docker container.

Installation
------------

    git clone https://github.com/stefaniuk/docker-postgresql.git
    cd docker-postgresql
    docker build -t stefaniuk/postgresql --rm .

Quick Start
-----------

    docker create \
        --name="postgresql" \
        --hostname="postgresql" \
        --env="DB_NAME=test" \
        --env="DB_USER=test" \
        --env="DB_PASS=test" \
        --volume=/var/lib/postgresql:/var/lib/postgresql \
        --publish=5432:5432 \
        stefaniuk/postgresql
    docker start postgresql
    docker exec -it postgresql /bin/bash --login

Additional Information
----------------------

You can login to the PostgreSQL interactive terminal

    docker exec -it postgresql \
        sudo -u postgres -H psql

TODO
----

 * Implement startup configuration lock mechanism
 * Configure PostgreSQL log messages format

See
---

 * [sameersbn/docker-postgresql](https://github.com/sameersbn/docker-postgresql)
 * [docker-library/postgres](https://github.com/docker-library/postgres)
