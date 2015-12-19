FROM stefaniuk/baseimage
MAINTAINER stefaniuk <daniel.stefaniuk@gmail.com>

# build-time environment variables set by the build script
ENV BUILD_APT_PROXY ${BUILD_APT_PROXY}

ENV POSTGRESQL_VER 9.4
ENV POSTGRESQL_HOME /var/lib/postgresql
ENV POSTGRESQL_CONFDIR /etc/postgresql/${POSTGRESQL_VER}/main
ENV POSTGRESQL_BINDIR /usr/lib/postgresql/${POSTGRESQL_VER}/bin
ENV POSTGRESQL_DATADIR ${POSTGRESQL_HOME}/${POSTGRESQL_VER}/main

ENV HOME /root
ADD ./assets /build/assets
ADD ./scripts /build/scripts
RUN /build/scripts/config.sh && \
    /build/scripts/install.sh && \
    /build/scripts/cleanup.sh # 20150727

# clear build-time environment variables
ENV BUILD_APT_PROXY ""

VOLUME /var/lib/postgresql
EXPOSE 5432

CMD ["/sbin/my_init"]
