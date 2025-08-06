# Use PHP 7.4 with Apache
FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files
COPY composer.json ./

# Install PHP dependencies (composer.lock will be copied with the full context)
RUN composer install --no-dev --optimize-autoloader

# Copy application files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configure Apache
RUN a2enmod rewrite
COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Create logs directory
RUN mkdir -p /var/www/html/logs && chmod 777 /var/www/html/logs

# Copy and set permissions for entrypoint script
COPY docker/entrypoint.sh /usr/local/bin/
COPY docker/entrypoint-debug.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/entrypoint-debug.sh

# Create a startup script that Railway will use
RUN echo '#!/bin/bash' > /usr/local/bin/start.sh && \
    echo 'echo "=== Railway Startup Script ==="' >> /usr/local/bin/start.sh && \
    echo 'echo "Current directory: $(pwd)"' >> /usr/local/bin/start.sh && \
    echo 'echo "Environment variables:"' >> /usr/local/bin/start.sh && \
    echo 'env | grep -E "(DB_|APP_|AUTH_|EMAIL_)" || echo "No relevant env vars found"' >> /usr/local/bin/start.sh && \
    echo 'echo "Creating configuration files..."' >> /usr/local/bin/start.sh && \
    echo 'if [ ! -f /var/www/html/config/database.php ]; then' >> /usr/local/bin/start.sh && \
    echo '  echo "Creating database.php..."' >> /usr/local/bin/start.sh && \
    echo '  cat > /var/www/html/config/database.php << EOF' >> /usr/local/bin/start.sh && \
    echo '<?php' >> /usr/local/bin/start.sh && \
    echo '\$config["db"]["dbname"] = "\${DB_NAME:-railway}";' >> /usr/local/bin/start.sh && \
    echo '\$config["db"]["user"] = "\${DB_USER:-root}";' >> /usr/local/bin/start.sh && \
    echo '\$config["db"]["pass"] = "\${DB_PASSWORD}";' >> /usr/local/bin/start.sh && \
    echo '\$config["db"]["host"] = "\${DB_HOST:-mysql.railway.internal}";' >> /usr/local/bin/start.sh && \
    echo '\$config["db"]["prefix"] = "\${DB_PREFIX:-cr_}";' >> /usr/local/bin/start.sh && \
    echo 'EOF' >> /usr/local/bin/start.sh && \
    echo '  echo "database.php created"' >> /usr/local/bin/start.sh && \
    echo 'else' >> /usr/local/bin/start.sh && \
    echo '  echo "database.php already exists"' >> /usr/local/bin/start.sh && \
    echo 'fi' >> /usr/local/bin/start.sh && \
    echo 'if [ ! -f /var/www/html/config/auth.php ]; then' >> /usr/local/bin/start.sh && \
    echo '  echo "Creating auth.php..."' >> /usr/local/bin/start.sh && \
    echo '  cat > /var/www/html/config/auth.php << EOF' >> /usr/local/bin/start.sh && \
    echo '<?php' >> /usr/local/bin/start.sh && \
    echo '\$config["auth"]["scheme"] = "\${AUTH_SCHEME:-database}";' >> /usr/local/bin/start.sh && \
    echo 'EOF' >> /usr/local/bin/start.sh && \
    echo '  echo "auth.php created"' >> /usr/local/bin/start.sh && \
    echo 'else' >> /usr/local/bin/start.sh && \
    echo '  echo "auth.php already exists"' >> /usr/local/bin/start.sh && \
    echo 'fi' >> /usr/local/bin/start.sh && \
    echo 'if [ ! -f /var/www/html/config/email.php ]; then' >> /usr/local/bin/start.sh && \
    echo '  echo "Creating email.php..."' >> /usr/local/bin/start.sh && \
    echo '  cat > /var/www/html/config/email.php << EOF' >> /usr/local/bin/start.sh && \
    echo '<?php' >> /usr/local/bin/start.sh && \
    echo '\$config["email"]["method"] = "\${EMAIL_METHOD:-mailgun}";' >> /usr/local/bin/start.sh && \
    echo 'EOF' >> /usr/local/bin/start.sh && \
    echo '  echo "email.php created"' >> /usr/local/bin/start.sh && \
    echo 'else' >> /usr/local/bin/start.sh && \
    echo '  echo "email.php already exists"' >> /usr/local/bin/start.sh && \
    echo 'fi' >> /usr/local/bin/start.sh && \
    echo 'if [ ! -f /var/www/html/config/recording.php ]; then' >> /usr/local/bin/start.sh && \
    echo '  echo "Creating recording.php..."' >> /usr/local/bin/start.sh && \
    echo '  cat > /var/www/html/config/recording.php << EOF' >> /usr/local/bin/start.sh && \
    echo '<?php' >> /usr/local/bin/start.sh && \
    echo '\$config["recording"]["enabled"] = \${RECORDING_ENABLED:-false};' >> /usr/local/bin/start.sh && \
    echo 'EOF' >> /usr/local/bin/start.sh && \
    echo '  echo "recording.php created"' >> /usr/local/bin/start.sh && \
    echo 'else' >> /usr/local/bin/start.sh && \
    echo '  echo "recording.php already exists"' >> /usr/local/bin/start.sh && \
    echo 'fi' >> /usr/local/bin/start.sh && \
    echo 'echo "Setting permissions..."' >> /usr/local/bin/start.sh && \
    echo 'chown -R www-data:www-data /var/www/html' >> /usr/local/bin/start.sh && \
    echo 'chmod -R 755 /var/www/html' >> /usr/local/bin/start.sh && \
    echo 'chmod 777 /var/www/html/logs' >> /usr/local/bin/start.sh && \
    echo 'echo "=== Starting Apache ==="' >> /usr/local/bin/start.sh && \
    echo 'exec apache2-foreground' >> /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start.sh

# Expose port
EXPOSE 80

# Use the startup script
CMD ["/usr/local/bin/start.sh"] 