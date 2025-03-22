#!/bin/bash

# setup-ssl.sh - SSL configuration script for ASCII renderer application
# This script sets up SSL certificates using Let's Encrypt

set -e # Exit immediately if a command exits with a non-zero status

# Get script directory with absolute path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ENV_FILE="$SCRIPT_DIR/.env"

# Load environment variables
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
    echo "Loaded environment from $ENV_FILE"
    echo "Domain: $DOMAIN"
    echo "Email: $EMAIL"
else
    echo "Error: .env file not found at $ENV_FILE. Please create it before running this script."
    exit 1
fi

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up SSL for $DOMAIN...${NC}"

# Check if Nginx is installed
if ! command -v nginx &> /dev/null; then
    echo -e "${RED}Error: Nginx is not installed.${NC}"
    echo -e "${YELLOW}Please run the domain setup script first.${NC}"
    exit 1
fi

# Check if certbot is installed
if ! command -v certbot &> /dev/null; then
    echo -e "${YELLOW}Installing certbot and python3-certbot-nginx...${NC}"
    sudo apt-get install -y certbot python3-certbot-nginx
fi

# Check if domain is properly configured in Nginx
if [ ! -f "/etc/nginx/sites-enabled/$PROJECT_DIR" ]; then
    echo -e "${RED}Error: Nginx configuration for $DOMAIN not found.${NC}"
    echo -e "${YELLOW}Please run the domain setup script first.${NC}"
    exit 1
fi

# Obtain SSL certificate
echo -e "${YELLOW}Obtaining SSL certificate for $DOMAIN...${NC}"
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN --non-interactive --agree-tos --email $EMAIL --redirect

# Set up automatic renewal
echo -e "${YELLOW}Setting up automatic renewal...${NC}"
(crontab -l 2>/dev/null; echo "0 12 * * * /usr/bin/certbot renew --quiet") | sort - | uniq - | crontab -

echo -e "${GREEN}SSL setup for $DOMAIN completed successfully!${NC}"
echo -e "${BLUE}Your site is now accessible at https://$DOMAIN${NC}"