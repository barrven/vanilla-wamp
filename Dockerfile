# Use official PHP image with PHP-FPM
FROM php:8.1-fpm

# Install dependencies for Nginx, SQLite, and required PHP extensions
RUN apt-get update && apt-get install -y \
    nginx \
    libsqlite3-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-install pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer for PHP dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy application code (assuming your project files are in the current directory)
COPY . .

# Install PHP dependencies (e.g., Stripe SDK, SendGrid)
RUN composer install --no-dev --optimize-autoloader

# Configure Nginx
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy custom PHP-FPM configuration (optional, for tuning)
COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN mkdir -p /var/www/html/data \
    && chown -R www-data:www-data /var/www/html/data \
    && chmod -R 755 /var/www/html/data

# Expose port 80 for web access
EXPOSE 80

# Copy entrypoint script to start both PHP-FPM and Nginx
COPY entrypoint.sh /entrypoint.sh
RUN apt-get update && apt-get install -y dos2unix
RUN dos2unix /entrypoint.sh
RUN chmod +x /entrypoint.sh


RUN apt-get update && apt-get install -y procps

# Start services
ENTRYPOINT ["/entrypoint.sh"]