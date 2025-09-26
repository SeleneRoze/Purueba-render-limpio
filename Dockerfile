# Base PHP 8.2 FPM
FROM php:8.2-fpm

WORKDIR /var/www/html
ENV DEBIAN_FRONTEND=noninteractive

# Instalar paquetes base y extensiones PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev libonig-dev libicu-dev libxml2-dev \
    && docker-php-ext-install zip mbstring bcmath intl xml

# Copiar proyecto
COPY . .

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer puerto
EXPOSE 8000

# Comando para levantar Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
