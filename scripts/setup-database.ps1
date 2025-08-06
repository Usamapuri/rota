# Database Setup Script for Rota Management Software
# This script helps you set up the database tables in Railway MySQL

Write-Host "Database Setup for Rota Management Software" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""

# Database connection details from Railway
$DB_HOST = "shinkansen.proxy.rlwy.net"
$DB_PORT = "46954"
$DB_NAME = "railway"
$DB_USER = "root"
$DB_PASSWORD = "cRyfgtFAITBVWVNPkYFksVZDMSBvsgBo"

Write-Host "Database Connection Details:" -ForegroundColor Yellow
Write-Host "Host: $DB_HOST" -ForegroundColor White
Write-Host "Port: $DB_PORT" -ForegroundColor White
Write-Host "Database: $DB_NAME" -ForegroundColor White
Write-Host "User: $DB_USER" -ForegroundColor White
Write-Host ""

Write-Host "Option 1: Use Railway CLI to connect to database" -ForegroundColor Yellow
Write-Host "==================================================" -ForegroundColor Yellow
Write-Host "1. Run: railway connect" -ForegroundColor Cyan
Write-Host "2. Select MySQL service" -ForegroundColor Cyan
Write-Host "3. This will open a MySQL shell" -ForegroundColor Cyan
Write-Host "4. Run the SQL commands from generated-sql/default.sql" -ForegroundColor Cyan
Write-Host ""

Write-Host "Option 2: Use MySQL client directly" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow
Write-Host "If you have MySQL client installed:" -ForegroundColor White
Write-Host "mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD $DB_NAME < generated-sql/default.sql" -ForegroundColor Cyan
Write-Host ""

Write-Host "Option 3: Use the application's installation wizard" -ForegroundColor Yellow
Write-Host "=====================================================" -ForegroundColor Yellow
Write-Host "1. Set the environment variables in Railway dashboard" -ForegroundColor White
Write-Host "2. Deploy the application" -ForegroundColor White
Write-Host "3. Visit the application URL" -ForegroundColor White
Write-Host "4. The app will automatically create tables on first run" -ForegroundColor White
Write-Host ""

Write-Host "Manual Database Setup Steps:" -ForegroundColor Yellow
Write-Host "=============================" -ForegroundColor Yellow
Write-Host "1. Connect to your Railway MySQL database" -ForegroundColor White
Write-Host "2. Create the database if it doesn't exist:" -ForegroundColor White
Write-Host "   CREATE DATABASE IF NOT EXISTS railway;" -ForegroundColor Cyan
Write-Host "3. Use the database:" -ForegroundColor White
Write-Host "   USE railway;" -ForegroundColor Cyan
Write-Host "4. Run the SQL commands from generated-sql/default.sql" -ForegroundColor White
Write-Host ""

Write-Host "Key Tables that will be created:" -ForegroundColor Yellow
Write-Host "=================================" -ForegroundColor Yellow
Write-Host "- availability" -ForegroundColor White
Write-Host "- calendarTokens" -ForegroundColor White
Write-Host "- discussion" -ForegroundColor White
Write-Host "- documents" -ForegroundColor White
Write-Host "- emails" -ForegroundColor White
Write-Host "- events" -ForegroundColor White
Write-Host "- eventPeople" -ForegroundColor White
Write-Host "- eventTypes" -ForegroundColor White
Write-Host "- groups" -ForegroundColor White
Write-Host "- roles" -ForegroundColor White
Write-Host "- settings" -ForegroundColor White
Write-Host "- sites" -ForegroundColor White
Write-Host "- users" -ForegroundColor White
Write-Host ""

Write-Host "Recommended approach:" -ForegroundColor Green
Write-Host "1. Set environment variables in Railway dashboard" -ForegroundColor White
Write-Host "2. Deploy the application" -ForegroundColor White
Write-Host "3. Let the application handle database setup automatically" -ForegroundColor White
Write-Host ""

Write-Host "Ready to proceed with database setup!" -ForegroundColor Green 