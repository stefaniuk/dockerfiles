FROM ubuntu:14.04
MAINTAINER stefaniuk <daniel.stefaniuk@gmail.com>

# build-time environment variables set by the build script
ENV BUILD_APT_PROXY ${BUILD_APT_PROXY}

ENV HOME /root
ADD ./assets /build/assets
ADD ./scripts /build/scripts
RUN /build/scripts/config.sh && \
    /build/scripts/install.sh && \
    /build/scripts/cleanup.sh # 20150727

# clear build-time environment variables
ENV BUILD_APT_PROXY ""

CMD ["/sbin/my_init"]
