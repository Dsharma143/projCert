# Use the official PHP image as the base image
FROM php:7.4-apache

# Copy the PHP application to the Apache document root
COPY ./website/ /var/www/html/

# Copy custom Apache configuration
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Set file permissions
RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

# Enable Apache mod_rewrite (if your app needs it)
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
