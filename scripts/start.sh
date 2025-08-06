#!/bin/bash

# Railway startup script for Rota Management System
echo "=== Starting Rota Management System ==="

# Create config files from environment variables
echo "Creating configuration files..."

# Database config
cat > config/database.php << EOF
<?php
\$config['db']['dbname'] = '${DB_NAME:-railway}';
\$config['db']['user'] = '${DB_USER:-root}';
\$config['db']['pass'] = '${DB_PASSWORD}';
\$config['db']['host'] = '${DB_HOST:-mysql.railway.internal}';
\$config['db']['prefix'] = '${DB_PREFIX:-cr_}';
\$config['displayErrorDetails'] = false;
EOF

# Auth config
cat > config/auth.php << EOF
<?php
\$config['auth']['scheme'] = '${AUTH_SCHEME:-database}';
EOF

# Email config
cat > config/email.php << EOF
<?php
\$config['email']['method'] = '${EMAIL_METHOD:-mailgun}';
EOF

# Recording config
cat > config/recording.php << EOF
<?php
\$config['recording']['enabled'] = ${RECORDING_ENABLED:-false};
EOF

echo "Configuration files created successfully!"

# Start PHP development server with custom configuration
echo "Starting PHP server on port ${PORT:-8080}..."
php -c php.ini -S 0.0.0.0:${PORT:-8080} -t public public/index.php 