# Imagen base PHP con Composer y PostgreSQL
FROM php:8.2-cli

# Instalar dependencias de sistema
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git \
    && docker-php-ext-install pdo pdo_pgsql

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Crear carpeta de trabajo
WORKDIR /var/www

# Copiar proyecto
COPY . .

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Generar key si no existe
RUN php artisan key:generate --ansi || true

# Exponer puerto
EXPOSE 8080

# Comando de arranque
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
