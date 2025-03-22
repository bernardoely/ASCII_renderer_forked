#!/bin/bash

# configure_environment.sh - Environment configuration script for ASCII renderer application
# This script configures the environment for the application

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

echo -e "${GREEN}Configuring environment for $DOMAIN...${NC}"

# Configure firewall
echo -e "${YELLOW}Configuring firewall...${NC}"
if command -v ufw &> /dev/null; then
    sudo ufw allow $PORT/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw allow 22/tcp
    
    # Enable firewall if not already enabled
    if ! sudo ufw status | grep -q "Status: active"; then
        echo -e "${YELLOW}Enabling firewall...${NC}"
        sudo ufw --force enable
    fi
    
    echo -e "${YELLOW}Firewall status:${NC}"
    sudo ufw status
else
    echo -e "${YELLOW}UFW (Uncomplicated Firewall) not installed. Skipping firewall configuration.${NC}"
fi

echo -e "${GREEN}Environment configuration completed.${NC}"
echo -e "${YELLOW}Next step: Run deploy.sh to build and deploy the application.${NC}"
