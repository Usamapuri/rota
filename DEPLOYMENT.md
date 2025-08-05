# Rota Management Software - Railway Deployment Guide

This guide will help you deploy the Rota Management Software to Railway using Docker.

## Prerequisites

1. **Railway Account**: Sign up at [railway.app](https://railway.app)
2. **Git Repository**: Your code should be in a Git repository (GitHub, GitLab, etc.)
3. **Database**: You'll need a MySQL database (Railway provides this)

## Step 1: Prepare Your Repository

Ensure your repository contains all the necessary files:
- `Dockerfile`
- `docker/` directory with configuration files
- `railway.json`
- All application files

## Step 2: Set Up Railway Project

1. Go to [railway.app](https://railway.app) and sign in
2. Click "New Project"
3. Choose "Deploy from GitHub repo"
4. Select your repository
5. Railway will automatically detect the Dockerfile and start building

## Step 3: Add MySQL Database

1. In your Railway project dashboard, click "New"
2. Select "Database" → "MySQL"
3. Railway will provision a MySQL database
4. Note down the connection details (host, port, database name, username, password)

## Step 4: Configure Environment Variables

In your Railway project dashboard, go to the "Variables" tab and add the following environment variables:

### Database Configuration
```
DB_HOST=<your-mysql-host>
DB_NAME=<your-database-name>
DB_USER=<your-database-user>
DB_PASSWORD=<your-database-password>
DB_PREFIX=cr_
```

### Application Configuration
```
APP_ENV=production
AUTH_SCHEME=database
EMAIL_METHOD=mailgun
```

### Email Configuration (if using Mailgun)
```
MAILGUN_API_BASE_URL=https://api.mailgun.net/v3/your-domain.com
MAILGUN_API_KEY=your-mailgun-api-key
```

### Optional: Facebook Authentication
```
FACEBOOK_ENABLED=false
FACEBOOK_APP_ID=your-facebook-app-id
FACEBOOK_APP_SECRET=your-facebook-app-secret
```

### Optional: OneBody Integration
```
ONEBODY_EMAIL=admin@example.com
ONEBODY_API_KEY=your-onebody-api-key
ONEBODY_URL=https://your-onebody-instance.com
```

### Optional: Recording Configuration
```
RECORDING_ENABLED=false
RECORDING_PATH=/var/www/html/recordings
```

## Step 5: Deploy

1. Railway will automatically deploy your application when you push changes to your repository
2. You can also manually trigger deployments from the Railway dashboard
3. Monitor the deployment logs to ensure everything builds correctly

## Step 6: Access Your Application

1. Once deployed, Railway will provide you with a public URL
2. Navigate to the URL to access your application
3. The first time you access it, you'll be redirected to the installation page
4. Follow the installation wizard to set up your first user

## Step 7: Custom Domain (Optional)

1. In your Railway project dashboard, go to "Settings"
2. Click "Custom Domains"
3. Add your custom domain and configure DNS as instructed

## Local Development

To test locally before deploying:

```bash
# Build and run with docker-compose
docker-compose up --build

# Access the application at http://localhost:8080
```

## Troubleshooting

### Common Issues

1. **Database Connection Errors**: Ensure all database environment variables are correctly set
2. **Permission Errors**: The Dockerfile sets appropriate permissions, but you may need to adjust if using different file systems
3. **Build Failures**: Check the Railway build logs for specific error messages

### Logs

- Application logs are available in the Railway dashboard
- Database logs can be viewed in the MySQL service dashboard
- Apache logs are written to `/var/log/apache2/` inside the container

### Health Checks

Railway will automatically check if your application is healthy by making requests to the root path (`/`). If the health check fails, Railway will restart your application.

## Security Considerations

1. **Environment Variables**: Never commit sensitive information like API keys to your repository
2. **Database Security**: Use strong passwords for your database
3. **HTTPS**: Railway automatically provides HTTPS for your application
4. **Updates**: Regularly update your application and dependencies

## Support

If you encounter issues:
1. Check the Railway documentation: [docs.railway.app](https://docs.railway.app)
2. Review the application logs in the Railway dashboard
3. Ensure all environment variables are correctly configured 