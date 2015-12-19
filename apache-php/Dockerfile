FROM stefaniuk/baseimage
MAINTAINER stefaniuk <daniel.stefaniuk@gmail.com>

# build-time environment variables set by the build script
ENV BUILD_APT_PROXY ${BUILD_APT_PROXY}

ENV APACHE_SERVERNAME localhost
ENV APACHE_DOCUMENTROOT /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2

ENV HOME /root
ADD ./assets /build/assets
ADD ./scripts /build/scripts
COPY ./application/* /var/www/
RUN /build/scripts/config.sh && \
    /build/scripts/install.sh && \
    /build/scripts/cleanup.sh # 20150727

# clear build-time environment variables
ENV BUILD_APT_PROXY ""

VOLUME /var/www
EXPOSE 80 443

CMD ["/sbin/my_init"]
