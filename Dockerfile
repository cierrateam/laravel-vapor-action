FROM composer:1.9.0

LABEL repository="https://github.com/cierrateam/laravel-vapor-action"
LABEL homepage="https://cierra.de"
LABEL maintainer="Vittorio Emmermann <vittorio@cierra.de>"

# Install required extenstions for laravel
# https://laravel.com/docs/6.x#server-requirements
RUN apk add libxml2-dev libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev gd && \
    docker-php-ext-install bcmath xml tokenizer mbstring gd


# Install Vapor + Prestissimo (parallel/quicker composer install)
RUN set -xe && \
    composer global require hirak/prestissimo && \
    composer global require laravel/vapor-cli && \
    composer clear-cache

# Install Node.js (needed for Vapor's NPM Build)
RUN apk add --update nodejs npm

# Prepare out Entrypoint (used to run Vapor commands)
COPY vapor-entrypoint /usr/local/bin/vapor-entrypoint

ENTRYPOINT ["/usr/local/bin/vapor-entrypoint"]
