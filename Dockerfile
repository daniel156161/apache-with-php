FROM php:8.4-apache

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install Composer from the official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set the working directory inside the container
WORKDIR /var/www/html
COPY ./src /var/www/html/

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
