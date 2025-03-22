#!/bin/bash

# setup_project.sh - Project setup script for ASCII renderer application
# This script clones the repository and installs dependencies

set -e # Exit immediately if a command exits with a non-zero status

# Get script directory with absolute path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"

# Load environment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
    echo "Loaded environment from $ENV_FILE"
    echo "Repository URL: $REPO_URL"
    echo "Project Directory: $PROJECT_DIR"
else
    echo "Error: .env file not found at $ENV_FILE. Please create it before running this script."
    exit 1
fi

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up project for $DOMAIN...${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed.${NC}"
    echo -e "${YELLOW}Please run install_dependencies.sh first.${NC}"
    exit 1
fi

# Clone the repository
if [ ! -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}Cloning repository from $REPO_URL...${NC}"
    git clone $REPO_URL $PROJECT_DIR
else
    echo -e "${YELLOW}Project directory already exists. Updating...${NC}"
    cd $PROJECT_DIR
    git pull
fi

# Navigate to project directory
echo -e "${YELLOW}Navigating to project directory...${NC}"
cd $PROJECT_DIR

# Install npm dependencies
echo -e "${YELLOW}Installing npm dependencies...${NC}"
npm install

echo -e "${GREEN}Project setup completed.${NC}"
echo -e "${YELLOW}Next step: Run configure_environment.sh to configure the environment.${NC}"
