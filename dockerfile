# Use the official PHP image as the base image
FROM php:7.4-apache

# Copy the PHP application to the Apache document root
COPY ./website/ /var/www/html/

# Set file permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose port 80
EXPOSE 80
