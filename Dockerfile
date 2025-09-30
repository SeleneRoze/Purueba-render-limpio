FROM php:8.2-cli

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git \
    && docker-php-ext-install pdo pdo_pgsql

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install --no-dev --optimize-autoloader

# Generar key si no existe
RUN php artisan key:generate --ansi || true

EXPOSE 8080

# 👇 Aquí está la magia: corre migrate + seed y después arranca Laravel
CMD php artisan migrate --force && php artisan db:seed --force && php artisan serve --host=0.0.0.0 --port=8080

