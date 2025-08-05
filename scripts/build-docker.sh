#!/bin/bash

# Script to build and push Docker image to GitHub Container Registry
# Usage: ./scripts/build-docker.sh [version]

set -e

# Configuration
REGISTRY="ghcr.io"
REPOSITORY="Usamapuri/rota"
VERSION=${1:-latest}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building Docker image for Rota Management Software${NC}"
echo -e "${YELLOW}Repository: ${REGISTRY}/${REPOSITORY}${NC}"
echo -e "${YELLOW}Version: ${VERSION}${NC}"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running. Please start Docker and try again.${NC}"
    exit 1
fi

# Build the Docker image
echo -e "${GREEN}Building Docker image...${NC}"
docker build -t ${REGISTRY}/${REPOSITORY}:${VERSION} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Docker image built successfully${NC}"
else
    echo -e "${RED}✗ Failed to build Docker image${NC}"
    exit 1
fi

# Ask user if they want to push the image
echo ""
read -p "Do you want to push the image to GitHub Container Registry? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Check if user is logged in to GitHub Container Registry
    if ! docker info | grep -q "Username"; then
        echo -e "${YELLOW}You need to log in to GitHub Container Registry first.${NC}"
        echo -e "${YELLOW}Run: echo \$GITHUB_TOKEN | docker login ghcr.io -u \$GITHUB_USERNAME --password-stdin${NC}"
        echo -e "${YELLOW}Or create a Personal Access Token with 'write:packages' permission${NC}"
        exit 1
    fi

    # Push the image
    echo -e "${GREEN}Pushing Docker image...${NC}"
    docker push ${REGISTRY}/${REPOSITORY}:${VERSION}

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Docker image pushed successfully${NC}"
        echo -e "${GREEN}Image available at: ${REGISTRY}/${REPOSITORY}:${VERSION}${NC}"
    else
        echo -e "${RED}✗ Failed to push Docker image${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Image built but not pushed. You can push it later with:${NC}"
    echo -e "${YELLOW}docker push ${REGISTRY}/${REPOSITORY}:${VERSION}${NC}"
fi

echo ""
echo -e "${GREEN}Done!${NC}" 