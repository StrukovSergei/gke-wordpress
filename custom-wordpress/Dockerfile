# Start from the official WordPress image
FROM wordpress:latest

# Copy wp-config.php into the WordPress directory
COPY wp-config.php /var/www/html/wp-config.php

# Copy the custom theme and plugin into the WordPress directory
COPY theme.zip /tmp/theme.zip
COPY plugin.zip /tmp/plugin.zip

# Unzip the theme and plugin to the appropriate WordPress directories
RUN apt-get update && apt-get install -y unzip && \
    unzip /tmp/theme.zip -d /var/www/html/wp-content/themes/ && \
    unzip /tmp/plugin.zip -d /var/www/html/wp-content/plugins/ && \
    rm /tmp/theme.zip /tmp/plugin.zip && \
    chown -R www-data:www-data /var/www/html/wp-content/themes /var/www/html/wp-content/plugins && \
    chown www-data:www-data /var/www/html/wp-config.php
