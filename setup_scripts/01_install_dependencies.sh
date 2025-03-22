#!/bin/bash

# install_dependencies.sh - Server setup script for ASCII renderer application
# This script installs all dependencies required for the application

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

echo -e "${GREEN}Starting server setup for $DOMAIN...${NC}"

# Update system packages
echo -e "${YELLOW}Updating system packages...${NC}"
sudo apt-get update
sudo apt-get upgrade -y

# Install essential packages
echo -e "${YELLOW}Installing essential packages...${NC}"
sudo apt-get install -y curl wget git build-essential net-tools

# Install Node.js and npm
echo -e "${YELLOW}Installing Node.js and npm...${NC}"
sudo apt-get install -y nodejs npm

# Install serve for deployment
echo -e "${YELLOW}Installing serve globally...${NC}"
sudo npm install -g serve

echo -e "${GREEN}Dependencies installation completed.${NC}"
echo -e "${YELLOW}Next step: Run setup_project.sh to set up the project.${NC}"
