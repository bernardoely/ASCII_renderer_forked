#!/bin/bash

# deploy.sh - Deployment script for ASCII renderer application
# This script builds and deploys the application

set -e # Exit immediately if a command exits with a non-zero status

# Get script directory with absolute path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"

# Load environment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
    echo "Loaded environment from $ENV_FILE"
else
    echo "Error: .env file not found at $ENV_FILE. Please create it before running this script."
    exit 1
fi

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting deployment for $DOMAIN...${NC}"

# Navigate to project directory
echo -e "${YELLOW}Navigating to project directory...${NC}"
cd $PROJECT_DIR || {
    echo -e "${RED}Error: Project directory $PROJECT_DIR not found.${NC}"
    echo -e "${YELLOW}Please run setup_project.sh first.${NC}"
    exit 1
}

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}Error: npm is not installed.${NC}"
    echo -e "${YELLOW}Please run install_dependencies.sh first.${NC}"
    exit 1
fi

# Build the project
echo -e "${YELLOW}Building the project...${NC}"
npm run build

# Check if build directory exists
if [ ! -d "build" ]; then
    echo -e "${RED}Error: Build directory not found. Build may have failed.${NC}"
    exit 1
fi

# Stop any existing serve process
echo -e "${YELLOW}Stopping any existing serve process...${NC}"
pkill -f "serve -s build" || true

# Deploy using serve
echo -e "${YELLOW}Deploying application using serve...${NC}"
nohup serve -s build -l $PORT > serve.log 2>&1 &

echo -e "${GREEN}Deployment completed!${NC}"
echo -e "${YELLOW}Application is now running on http://localhost:$PORT${NC}"
echo -e "${YELLOW}If you've configured a domain and SSL, it's also available at https://$DOMAIN${NC}"
