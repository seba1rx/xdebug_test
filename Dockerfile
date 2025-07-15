FROM php:8.3-apache

# Instalar dependencias del sistema y extensiones necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip

# Instalar Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copiar configuración de Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Habilitar mod_rewrite (útil para frameworks modernos)
RUN a2enmod rewrite

# Establecer directorio raíz del servidor
COPY public/ /var/www/html/
