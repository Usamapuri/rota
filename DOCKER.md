# Docker Deployment Guide

This guide explains how to build and deploy the Rota Management Software using Docker.

## Quick Start

### Option 1: Automatic Build (Recommended)

The easiest way to build and push Docker images is using GitHub Actions. Simply push your code to the repository and the image will be automatically built and pushed to GitHub Container Registry.

1. **Push your code** to the `main` or `master` branch
2. **Check the Actions tab** in your GitHub repository to monitor the build
3. **Find your image** at `ghcr.io/Usamapuri/rota:latest`

### Option 2: Manual Build

If you prefer to build locally:

```bash
# Make the build script executable
chmod +x scripts/build-docker.sh

# Build the image
./scripts/build-docker.sh

# Or build with a specific version
./scripts/build-docker.sh v1.0.0
```

## Docker Image Details

- **Base Image**: PHP 7.4 with Apache
- **Registry**: GitHub Container Registry (ghcr.io)
- **Repository**: `ghcr.io/Usamapuri/rota`
- **Tags**: `latest`, `main`, `master`, and version tags

## Using the Docker Image

### Pull the Image

```bash
docker pull ghcr.io/Usamapuri/rota:latest
```

### Run with Docker Compose

```bash
# Clone the repository
git clone https://github.com/Usamapuri/rota.git
cd rota

# Run with docker-compose
docker-compose up -d
```

### Run Manually

```bash
# Run the container
docker run -d \
  --name rota-app \
  -p 8080:80 \
  -e DB_HOST=your-db-host \
  -e DB_NAME=churchrota \
  -e DB_USER=your-db-user \
  -e DB_PASSWORD=your-db-password \
  -e APP_ENV=production \
  ghcr.io/Usamapuri/rota:latest
```

## Environment Variables

The Docker image supports the following environment variables:

### Required
- `DB_HOST`: Database host
- `DB_NAME`: Database name
- `DB_USER`: Database username
- `DB_PASSWORD`: Database password

### Optional
- `DB_PREFIX`: Database table prefix (default: `cr_`)
- `APP_ENV`: Application environment (default: `production`)
- `AUTH_SCHEME`: Authentication scheme (default: `database`)
- `EMAIL_METHOD`: Email method (default: `mailgun`)
- `MAILGUN_API_BASE_URL`: Mailgun API base URL
- `MAILGUN_API_KEY`: Mailgun API key

## GitHub Container Registry Authentication

To push images to GitHub Container Registry, you need to authenticate:

1. **Create a Personal Access Token**:
   - Go to GitHub Settings → Developer settings → Personal access tokens
   - Generate a new token with `write:packages` permission

2. **Login to the registry**:
   ```bash
   echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin
   ```

## Railway Deployment

To deploy to Railway using the Docker image:

1. **In Railway dashboard**, create a new project
2. **Choose "Deploy from GitHub repo"**
3. **Select your repository**
4. **Add environment variables** as specified in `DEPLOYMENT.md`
5. **Railway will automatically use the Dockerfile** to build and deploy

## Local Development

For local development with Docker:

```bash
# Build the development image
docker build -t rota-dev .

# Run with docker-compose (includes MySQL)
docker-compose up --build

# Access at http://localhost:8080
```

## Troubleshooting

### Build Issues

1. **Docker not running**: Ensure Docker Desktop is started
2. **Permission denied**: Make sure the build script is executable
3. **Network issues**: Check your internet connection for pulling base images

### Runtime Issues

1. **Database connection**: Verify all database environment variables are set
2. **Port conflicts**: Ensure port 8080 is available
3. **Permission errors**: The Dockerfile sets appropriate permissions

### Registry Issues

1. **Authentication failed**: Check your GitHub token has `write:packages` permission
2. **Push failed**: Ensure you're logged in to `ghcr.io`
3. **Image not found**: Verify the image was built successfully

## Security Notes

- Never commit sensitive information like API keys or passwords
- Use environment variables for all configuration
- Regularly update the base PHP image for security patches
- Consider using Docker secrets for production deployments

## Support

For issues with Docker deployment:
1. Check the GitHub Actions logs for build errors
2. Review the Docker build logs
3. Ensure all required files are present in the repository 