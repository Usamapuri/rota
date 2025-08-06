# Railway Deployment Troubleshooting Guide

## Current Issue: Application Failed to Respond

Your application is deployed but showing "Application failed to respond" error. Here's how to fix it:

## 🔍 Root Cause Analysis

The issue is likely one of these:

1. **Database tables don't exist** - The application is trying to connect to tables that haven't been created
2. **Configuration files missing** - The app needs config files to be generated from environment variables
3. **PHP errors** - There might be PHP errors preventing the application from starting

## 🛠️ Solution Steps

### Step 1: Set Up Database Tables

**Option A: Use Railway's Database Interface (Recommended)**

1. Go to your Railway dashboard
2. Click on the "MySQL" service
3. Go to the "Data" tab
4. Click "Create table" or use the SQL interface
5. Copy and paste the contents of `scripts/railway-db-setup.sql`
6. Run the SQL script

**Option B: Let the Application Create Tables**

1. The application should automatically create tables on first run
2. If it's not working, we need to check the logs

### Step 2: Check Application Logs

Run this command to see detailed logs:

```bash
railway logs --service rota --tail
```

Look for:
- PHP errors
- Database connection errors
- Missing file errors

### Step 3: Verify Configuration

The environment variables are set correctly, but let's make sure the application can read them:

1. **Check if config files are being created**:
   - The entrypoint script should create `config/database.php`, `config/auth.php`, etc.
   - If these files aren't being created, there might be a permission issue

2. **Test database connection**:
   - The application should be able to connect to `mysql.railway.internal:3306`
   - Database: `railway`
   - User: `root`
   - Password: `cRyfgtFAITBVWVNPkYFksVZDMSBvsgBo`

### Step 4: Redeploy with Debug Information

Let's add some debug environment variables:

```bash
# Add these to your Railway environment variables:
DEBUG=true
LOG_LEVEL=debug
```

## 🔧 Quick Fixes to Try

### Fix 1: Force Redeploy

1. In Railway dashboard, go to your "rota" service
2. Click "Deploy" to trigger a fresh deployment
3. This will rebuild the container with the latest code

### Fix 2: Check File Permissions

The application might not have permission to create config files. Add this environment variable:

```
CHMOD_CONFIG=true
```

### Fix 3: Database Connection Test

Add this environment variable to test database connection:

```
DB_TEST_CONNECTION=true
```

## 📋 Manual Database Setup

If the automatic setup isn't working, manually create the database tables:

1. **Go to Railway Dashboard** → MySQL service → Data tab
2. **Click "Create table"** or use the SQL interface
3. **Run this SQL**:

```sql
-- Create basic tables
CREATE TABLE IF NOT EXISTS cr_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    isAdmin BOOLEAN DEFAULT FALSE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cr_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    settingKey VARCHAR(255) NOT NULL UNIQUE,
    settingValue TEXT,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert basic settings
INSERT IGNORE INTO cr_settings (settingKey, settingValue) VALUES
('installation_complete', 'false'),
('site_name', 'Rota Management System');
```

## 🚨 Emergency Fix

If nothing else works, try this:

1. **Delete and recreate the service**:
   - Delete the "rota" service from Railway
   - Create a new service using the same Docker image
   - Set the environment variables again

2. **Use a different approach**:
   - Deploy using Railway's GitHub integration
   - Let Railway build from source instead of using the pre-built image

## 📞 Getting Help

If you're still having issues:

1. **Check Railway documentation**: https://docs.railway.app
2. **Review the logs**: `railway logs --service rota`
3. **Contact Railway support**: Use the Help Station in Railway dashboard

## ✅ Success Indicators

Your application is working when you see:

- ✅ Apache starts without errors
- ✅ PHP processes requests
- ✅ Database connection successful
- ✅ Application responds to HTTP requests
- ✅ You can access the login/installation page

## 🔄 Next Steps After Fix

Once the application is working:

1. **Visit the application URL**: `https://rota-production-86b8.up.railway.app`
2. **Complete the installation wizard**
3. **Create your first admin user**
4. **Configure your organization settings** 