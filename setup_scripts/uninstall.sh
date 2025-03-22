#!/bin/bash

# Source environment variables
source .env

# Stop the application
pkill -f "serve -s build"

# Remove the project directory
PROJECT_DIR="ASCII_renderer_forked"
rm -rf $PROJECT_DIR

# Uninstall global npm packages
sudo npm uninstall -g serve

# Optionally uninstall Node.js and npm
# sudo apt-get remove -y nodejs npm
