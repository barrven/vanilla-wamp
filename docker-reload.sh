#!/bin/bash
docker stop my-web-app
docker rm my-web-app

# Build the Docker image
docker build -t my-web-app .

# Run the container, mapping port 80 to host
docker run -d -p 8085:80 --name my-web-app my-web-app

# Verify Setup:
# Ensure the container is running (shows running containers): 
docker ps
docker logs my-web-app