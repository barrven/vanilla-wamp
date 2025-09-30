#!/bin/bash

# Build the Docker image
docker build -t my-web-app .

# Run the container, mapping port 80 to host
docker run -d -p 8085:80 --name my-web-app my-web-app

# Verify Setup:
# Ensure the container is running (shows running containers): 
docker ps

# Access the app at http://localhost (or https://localhost once SSL is configured).
# Check logs if needed: 
docker logs my-web-app

# Notes
# This setup assumes your application code will be in the public/ directory, with index.php as the entry point.
# SQLite database files will be stored in the container (e.g., /var/www/html/database.sqlite). Ensure the www-data user has write permissions.
# HTTPS is referenced in the Nginx config but requires SSL certificates (e.g., via Let’s Encrypt or self-signed for testing). For now, you can test on HTTP.
# The container includes Composer to install Stripe and SendGrid SDKs. Run composer install locally first if you need to generate vendor/ before building.
# Please confirm if you want to proceed with this Dockerfile setup or make adjustments before moving to the next step (e.g., setting up the SQLite database or user registration logic).

# restart the container
docker restart my-web-app

# stop container
docker stop my-web-app

# remove container
docker rm my-web-app

# find nginx processes
docker exec my-web-app ps aux | grep nginx

# test if web server is running locally in  the container
docker exec -it my-web-app curl -v http://localhost

# test the nginx config file
docker exec my-web-app nginx -t

