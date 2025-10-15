# Используем официальный образ PHP с Apache
FROM php:8.2-apache

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем PHP расширения
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем файлы проекта
COPY yii-basic/ /var/www/html/

# Устанавливаем зависимости Composer
RUN composer install --no-dev --optimize-autoloader

# Устанавливаем права доступа после копирования файлов
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Устанавливаем права для папок runtime и web/assets
RUN mkdir -p /var/www/html/runtime /var/www/html/web/assets \
    && chown -R www-data:www-data /var/www/html/runtime /var/www/html/web/assets \
    && chmod -R 777 /var/www/html/runtime /var/www/html/web/assets

# Настраиваем Apache для Yii2
RUN a2enmod rewrite

# Создаем конфигурацию Apache для Yii2
RUN echo 'ServerName localhost\n\
<VirtualHost *:80>\n\
    ServerName localhost\n\
    DocumentRoot /var/www/html/web\n\
    <Directory /var/www/html/web>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]