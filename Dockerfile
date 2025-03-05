ARG TAG=latest
FROM wordpress:$TAG
LABEL maintainer="Chazz W <https://github.com/chazz0x0>"

# Xdebug setup
ENV XDEBUG_PORT=9000
ENV XDEBUG_IDEKEY=docker

COPY ./data/build/install-xdebug.sh /
RUN bash /install-xdebug.sh \
    && docker-php-ext-enable xdebug \
    && rm /install-xdebug.sh

RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_port=${XDEBUG_PORT}" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.idekey=${XDEBUG_IDEKEY}" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.discover_client_host=On" >> /usr/local/etc/php/conf.d/xdebug.ini


# Enable larger file uploads
RUN { \
    echo 'file_uploads = On'; \
    echo 'memory_limit = 64M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 600'; \
} > /usr/local/etc/php/conf.d/upload.ini

# Install custom root certificate (if provided)
COPY ./data/build/ca.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Install custom mu-plugins
RUN mkdir -p /usr/src/wordpress/wp-content/mu-plugins
COPY ./data/build/mu-plugins/setMailServer.php /usr/src/wordpress/wp-content/mu-plugins/