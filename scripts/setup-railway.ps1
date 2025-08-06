# Railway Setup Script for Rota Management Software
# This script helps you set up the environment variables and database

Write-Host "🚂 Railway Setup for Rota Management Software" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""

# Database connection details from Railway
$DB_HOST = "mysql.railway.internal"
$DB_NAME = "railway"
$DB_USER = "root"
$DB_PASSWORD = "cRyfgtFAITBVWVNPkYFksVZDMSBvsgBo"
$DB_PREFIX = "cr_"

Write-Host "📋 Environment Variables to set in Railway Dashboard:" -ForegroundColor Yellow
Write-Host "=====================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Go to your Railway dashboard and add these variables to your 'rota' service:" -ForegroundColor White
Write-Host ""
Write-Host "DB_HOST=$DB_HOST" -ForegroundColor Cyan
Write-Host "DB_NAME=$DB_NAME" -ForegroundColor Cyan
Write-Host "DB_USER=$DB_USER" -ForegroundColor Cyan
Write-Host "DB_PASSWORD=$DB_PASSWORD" -ForegroundColor Cyan
Write-Host "DB_PREFIX=$DB_PREFIX" -ForegroundColor Cyan
Write-Host "APP_ENV=production" -ForegroundColor Cyan
Write-Host "AUTH_SCHEME=database" -ForegroundColor Cyan
Write-Host "EMAIL_METHOD=mailgun" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Steps to set up in Railway Dashboard:" -ForegroundColor Yellow
Write-Host "1. Go to your Railway project dashboard" -ForegroundColor White
Write-Host "2. Click on the 'rota' service" -ForegroundColor White
Write-Host "3. Go to the 'Variables' tab" -ForegroundColor White
Write-Host "4. Add each variable above" -ForegroundColor White
Write-Host "5. Deploy the service" -ForegroundColor White
Write-Host ""
Write-Host "🔗 Database Connection Details:" -ForegroundColor Yellow
Write-Host "Host: $DB_HOST" -ForegroundColor White
Write-Host "Database: $DB_NAME" -ForegroundColor White
Write-Host "User: $DB_USER" -ForegroundColor White
Write-Host "Port: 3306" -ForegroundColor White
Write-Host ""
Write-Host "🌐 After deployment, your app will be available at:" -ForegroundColor Yellow
Write-Host "https://your-app-name.railway.app" -ForegroundColor White
Write-Host ""
Write-Host "📖 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Set the environment variables in Railway dashboard" -ForegroundColor White
Write-Host "2. Deploy the application" -ForegroundColor White
Write-Host "3. Visit the application URL" -ForegroundColor White
Write-Host "4. Follow the installation wizard to set up the database tables" -ForegroundColor White
Write-Host "5. Create your first admin user" -ForegroundColor White
Write-Host ""
Write-Host "✅ Setup complete! Follow the steps above to configure your application." -ForegroundColor Green 