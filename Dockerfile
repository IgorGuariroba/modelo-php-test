FROM php:latest

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev

# Instala a extensão zip do PHP
RUN docker-php-ext-install zip

# Cria um usuário não-root
RUN useradd -m -s /bin/bash composer

# Instala o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define o usuário para o container
USER composer

WORKDIR /var/www/html

CMD ["php", "-S", "0.0.0.0:8000"]
