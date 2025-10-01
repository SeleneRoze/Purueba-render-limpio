# Usamos PHP CLI como base
FROM php:8.2-cli

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git \
    && docker-php-ext-install pdo pdo_pgsql

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Definir directorio de trabajo
WORKDIR /var/www

# Copiar el proyecto
COPY . .

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Generar key y migrar base de datos durante el build
RUN php artisan key:generate \
    && php artisan migrate --force \
    && php artisan db:seed --force

# Exponer puerto
EXPOSE 8080

# Comando de arranque para Render Free
CMD php -S 0.0.0.0:8080 -t public
