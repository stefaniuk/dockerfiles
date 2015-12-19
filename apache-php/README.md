docker-apache-php
=================

The aim of the `docker-apache-php` project is to build an Apache / PHP Docker container.

Installation
------------

    git clone https://github.com/stefaniuk/docker-apache-php.git
    cd docker-apache-php
    docker build -t stefaniuk/apache-php --rm .

Quick Start
-----------

    docker create \
        --name="apache-php" \
        --hostname="apache-php" \
        --volume=$(pwd)/application:/var/www \
        --publish=8080:80 \
        --publish=8443:443 \
        stefaniuk/apache-php
    docker start apache-php
    docker exec -it apache-php /bin/bash --login

TODO
----

 * Allow to choose PHP version

See
---

 * [bylexus/docker-apache-php](https://github.com/bylexus/docker-apache-php)
 * [docker-library/httpd](https://github.com/docker-library/httpd)
 * [docker-library/php](https://github.com/docker-library/php)
