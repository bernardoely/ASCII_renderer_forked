#!/bin/bash

# Source environment variables
source .env

# Navigate to project directory
PROJECT_DIR="ASCII_renderer_forked"
cd $PROJECT_DIR

# Pull latest changes from repository
git pull

# Reinstall dependencies
npm install

# Rebuild the project
npm run build

# Restart the application
pkill -f "serve -s build"
serve -s build -l $PORT
