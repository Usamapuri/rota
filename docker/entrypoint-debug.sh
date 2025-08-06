#!/bin/bash

# Debug entrypoint script for Railway deployment
set -e

echo "=== Railway Debug Entrypoint Script ==="
echo "Current directory: $(pwd)"
echo "Environment variables:"
env | grep -E "(DB_|APP_|AUTH_|EMAIL_)" || echo "No relevant env vars found"

# Create config files from environment variables
echo "Creating configuration files..."

# Database config
if [ ! -f /var/www/html/config/database.php ]; then
    echo "Creating database.php..."
    cat > /var/www/html/config/database.php << EOF
<?php
\$config['db']['dbname'] = '${DB_NAME:-railway}';
\$config['db']['user'] = '${DB_USER:-root}';
\$config['db']['pass'] = '${DB_PASSWORD}';
\$config['db']['host'] = '${DB_HOST:-mysql.railway.internal}';
\$config['db']['prefix'] = '${DB_PREFIX:-cr_}';
EOF
    echo "database.php created"
else
    echo "database.php already exists"
fi

# Auth config
if [ ! -f /var/www/html/config/auth.php ]; then
    echo "Creating auth.php..."
    cat > /var/www/html/config/auth.php << EOF
<?php
\$config['auth']['scheme'] = '${AUTH_SCHEME:-database}';
\$config['auth']['facebook']['enabled'] = ${FACEBOOK_ENABLED:-false};
\$config['auth']['facebook']['appId'] = '${FACEBOOK_APP_ID}';
\$config['auth']['facebook']['appSecret'] = '${FACEBOOK_APP_SECRET}';
\$config['auth']['onebody']['email'] = '${ONEBODY_EMAIL}';
\$config['auth']['onebody']['apiKey'] = '${ONEBODY_API_KEY}';
\$config['auth']['onebody']['url'] = '${ONEBODY_URL}';
EOF
    echo "auth.php created"
else
    echo "auth.php already exists"
fi

# Email config
if [ ! -f /var/www/html/config/email.php ]; then
    echo "Creating email.php..."
    cat > /var/www/html/config/email.php << EOF
<?php
\$config['email']['method'] = '${EMAIL_METHOD:-mailgun}';
\$config['email']['mailgun']['apiBaseUrl'] = '${MAILGUN_API_BASE_URL}';
\$config['email']['mailgun']['apiKey'] = '${MAILGUN_API_KEY}';
EOF
    echo "email.php created"
else
    echo "email.php already exists"
fi

# Recording config
if [ ! -f /var/www/html/config/recording.php ]; then
    echo "Creating recording.php..."
    cat > /var/www/html/config/recording.php << EOF
<?php
\$config['recording']['enabled'] = ${RECORDING_ENABLED:-false};
\$config['recording']['path'] = '${RECORDING_PATH:-/var/www/html/recordings}';
EOF
    echo "recording.php created"
else
    echo "recording.php already exists"
fi

# Set permissions
echo "Setting permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod 777 /var/www/html/logs

# Test database connection
echo "Testing database connection..."
if [ "$DB_TEST_CONNECTION" = "true" ]; then
    echo "Attempting to connect to database..."
    php -r "
    try {
        \$pdo = new PDO('mysql:host=${DB_HOST};dbname=${DB_NAME}', '${DB_USER}', '${DB_PASSWORD}');
        echo 'Database connection successful\n';
        \$stmt = \$pdo->query('SELECT COUNT(*) FROM cr_settings');
        \$count = \$stmt->fetchColumn();
        echo 'Found ' . \$count . ' settings records\n';
    } catch (Exception \$e) {
        echo 'Database connection failed: ' . \$e->getMessage() . '\n';
    }
    "
fi

echo "=== Starting Apache ==="
exec apache2-foreground 