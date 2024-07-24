ARG PHP_VERSION
FROM php:${PHP_VERSION}

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    autoconf \
    g++ \
    make \
    pkg-config

# Instala a extensão zip do PHP
RUN docker-php-ext-install zip

# Instala o Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copia o arquivo de configuração do Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Cria um usuário não-root
RUN useradd -m -s /bin/bash composer

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define o usuário para o container
USER composer

WORKDIR /var/www/html

CMD ["php", "-S", "0.0.0.0:8000"]
