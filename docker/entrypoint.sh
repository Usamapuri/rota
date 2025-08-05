#!/bin/bash

# Create config files from environment variables if they don't exist
if [ ! -f /var/www/html/config/database.php ]; then
    cat > /var/www/html/config/database.php << EOF
<?php
\$config['db']['dbname'] = '${DB_NAME:-churchrota}';
\$config['db']['user'] = '${DB_USER:-root}';
\$config['db']['pass'] = '${DB_PASSWORD}';
\$config['db']['host'] = '${DB_HOST:-localhost}';
\$config['db']['prefix'] = '${DB_PREFIX:-cr_}';
EOF
fi

if [ ! -f /var/www/html/config/auth.php ]; then
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
fi

if [ ! -f /var/www/html/config/email.php ]; then
    cat > /var/www/html/config/email.php << EOF
<?php
\$config['email']['method'] = '${EMAIL_METHOD:-mailgun}';
\$config['email']['mailgun']['apiBaseUrl'] = '${MAILGUN_API_BASE_URL}';
\$config['email']['mailgun']['apiKey'] = '${MAILGUN_API_KEY}';
EOF
fi

if [ ! -f /var/www/html/config/recording.php ]; then
    cat > /var/www/html/config/recording.php << EOF
<?php
\$config['recording']['enabled'] = ${RECORDING_ENABLED:-false};
\$config['recording']['path'] = '${RECORDING_PATH:-/var/www/html/recordings}';
EOF
fi

# Set display error details based on environment
if [ "$APP_ENV" = "production" ]; then
    sed -i "s/'displayErrorDetails' => true/'displayErrorDetails' => false/" /var/www/html/src/config.php
else
    sed -i "s/'displayErrorDetails' => false/'displayErrorDetails' => true/" /var/www/html/src/config.php
fi

# Start Apache
exec apache2-foreground 