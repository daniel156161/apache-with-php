FROM ubuntu:latest

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get update -y && apt-get install -y software-properties-common && apt-add-repository universe && add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y apache2 php8.3 libapache2-mod-php8.3 php8.3-mysql apt-utils tzdata nano && apt-get clean

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR
RUN mkdir -p $APACHE_LOCK_DIR
RUN mkdir -p $APACHE_LOG_DIR

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
