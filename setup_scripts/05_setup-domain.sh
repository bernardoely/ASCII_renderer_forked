#!/bin/bash

# setup-domain.sh - Domain configuration script for ASCII renderer
# This script sets up Nginx to serve the application

set -e # Exit immediately if a command exits with a non-zero status

# Get script directory with absolute path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"

# Load environment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
    echo "Loaded environment from $ENV_FILE"
    echo "Domain: $DOMAIN"
    echo "Server IP: $SERVER_IP"
else
    echo "Error: .env file not found at $ENV_FILE. Please create it before running this script."
    exit 1
fi

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up domain configuration for $DOMAIN...${NC}"

# Check if Nginx is installed
if ! command -v nginx &> /dev/null; then
    echo -e "${RED}Error: Nginx is not installed.${NC}"
    echo -e "${YELLOW}Installing Nginx...${NC}"
    sudo apt-get install -y nginx
fi

# Create Nginx configuration file
echo -e "${YELLOW}Creating Nginx configuration...${NC}"
sudo tee /etc/nginx/sites-available/$PROJECT_DIR > /dev/null << EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    location / {
        proxy_pass http://localhost:$PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable the site
echo -e "${YELLOW}Enabling site configuration...${NC}"
sudo ln -sf /etc/nginx/sites-available/$PROJECT_DIR /etc/nginx/sites-enabled/

# Test Nginx configuration
echo -e "${YELLOW}Testing Nginx configuration...${NC}"
sudo nginx -t

# Reload Nginx to apply changes
echo -e "${YELLOW}Reloading Nginx...${NC}"
sudo systemctl reload nginx

echo -e "${GREEN}Domain configuration for $DOMAIN completed.${NC}"
echo -e "${YELLOW}Next step: Run setup-ssl.sh to configure SSL certificates.${NC}"