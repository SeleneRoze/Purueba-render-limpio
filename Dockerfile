# 1️⃣ Base PHP 8.2 FPM
FROM php:8.2-fpm

# 2️⃣ Directorio de trabajo
WORKDIR /var/www/html
ENV DEBIAN_FRONTEND=noninteractive

# 3️⃣ Paquetes base y extensiones PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev libonig-dev libicu-dev libxml2-dev \
    gnupg2 apt-transport-https unixodbc-dev \
    && docker-php-ext-install zip mbstring bcmath intl xml

# 4️⃣ Instalar Microsoft ODBC Driver para SQL Server y extensiones PHP
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# 5️⃣ Copiar proyecto
COPY . .

# 6️⃣ Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 7️⃣ Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# 8️⃣ Permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# 9️⃣ Exponer puerto
EXPOSE 8000

# 🔟 Comando para levantar Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
