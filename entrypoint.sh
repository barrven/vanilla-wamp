#!/bin/bash
set -e

php-fpm -D       # start PHP-FPM in background
exec nginx -g 'daemon off;'  # keep nginx in foreground
