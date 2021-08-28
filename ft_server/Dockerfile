#install debian buster
FROM debian:buster

#update
RUN apt update
RUN apt -y upgrade

#install all services
RUN apt -y install nginx
RUN apt -y install mariadb-server
RUN apt -y install php-mysql php-fpm
RUN apt -y install wget
RUN apt -y install openssl

#install nginx
RUN mkdir /var/www/wordpress
RUN chmod -R 755 /var/www/*
COPY srcs/default.conf /etc/nginx/sites-available/wordpress
RUN ln -s /etc/nginx/sites-available/wordpress etc/nginx/sites-enabled/

#install auto-index script
COPY srcs/auto-index.sh ./
RUN chmod +x auto-index.sh

#install PHPmyadmin
RUN mkdir /var/www/phpmyadmin
RUN cd /tmp && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && tar xzf phpMyAdmin-5.0.1-english.tar.gz
RUN mv /tmp/phpMyAdmin-5.0.1-english/* /var/www/phpmyadmin/

#install wordpress
COPY srcs/wp-config.php /var/www/wordpress/
RUN cd /tmp && wget https://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz
RUN mv /tmp/wordpress/* /var/www/wordpress/
RUN chown -R www-data:www-data /var/www/*

#install MySql
COPY srcs/wordpress.sql /tmp/
COPY srcs/mysql.sh /tmp/
RUN bash /tmp/mysql.sh

#isntall ssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/local.pem -days 365 -subj "/C=FR/ST=FRANCE/L=PARIS/O=42/OU=42PARIS/CN=echoppin"

#start
COPY srcs/init_container.sh ./
RUN chmod +x init_container.sh
CMD bash init_container.sh
