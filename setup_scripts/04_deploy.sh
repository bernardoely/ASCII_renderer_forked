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

# Create a systemd service file for the application
echo -e "${YELLOW}Creating systemd service for the application...${NC}"
SERVICE_NAME="ascii-renderer"
APP_DIR=$(pwd)

sudo tee /etc/systemd/system/${SERVICE_NAME}.service > /dev/null << EOF
[Unit]
Description=ASCII Renderer Web Application
After=network.target

[Service]
Type=simple
User=$(whoami)
WorkingDirectory=${APP_DIR}
ExecStart=$(which npx) serve -s build -l ${PORT}
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=${SERVICE_NAME}
Environment=NODE_ENV=production PORT=${PORT}

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start service
echo -e "${YELLOW}Enabling and starting the service...${NC}"
sudo systemctl daemon-reload
sudo systemctl enable ${SERVICE_NAME}
sudo systemctl restart ${SERVICE_NAME}

# Check service status
echo -e "${YELLOW}Checking service status...${NC}"
sudo systemctl status ${SERVICE_NAME}

echo -e "${GREEN}Deployment completed!${NC}"
echo -e "${YELLOW}Application is now running as a system service on http://localhost:$PORT${NC}"
echo -e "${YELLOW}If you've configured a domain and SSL, it's also available at https://$DOMAIN${NC}"
echo -e "${YELLOW}To check service status: sudo systemctl status ${SERVICE_NAME}${NC}"
echo -e "${YELLOW}To restart service: sudo systemctl restart ${SERVICE_NAME}${NC}"
echo -e "${YELLOW}To view logs: sudo journalctl -u ${SERVICE_NAME}${NC}"
