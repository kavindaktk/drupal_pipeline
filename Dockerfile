#Base Image
 FROM phusion/baseimage:master-amd64
  #Maintainer
 MAINTAINER Kavinda Thisara <kavindatk@gmail.com>;
 #locale settings for Ubuntu
 RUN locale-gen en_US.UTF-8
 ENV LANG       en_US.UTF-8
 ENV LC_ALL     en_US.UTF-8
#Install Necessary Software
 RUN apt-get update -y
 RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y vim curl wget
 RUN add-apt-repository -y ppa:ondrej/php
 RUN apt-get update -y
#Install Apache and PHP 
 RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes php7.2-cli  \
  php7.2-mysql  php7.2-curl php7.2-gd php7.2-mcrypt apache2 libapache2-mod-php7.2
 RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
 RUN php drush core-status
 RUN chmod +x drush
 RUN apt-get install unzip -y
 RUN mv drush /usr/local/bin
 RUN drush init
 RUN phpenmod mcrypt
 RUN a2enmod rewrite
#Use baseimage-docker's init system.
 CMD ["/sbin/my_init"]
#apache2 Environment Variables, and config settings
 ENV APACHE_RUN_USER www-data
 ENV APACHE_RUN_GROUP www-data
 ENV APACHE_LOG_DIR /var/log/apache2
 ENV APACHE_LOCK_DIR /var/lock/apache2
 #ENV APACHE_PID_FILE=/var/run/apache2.pid 
#runit service files
 COPY ./apache2-run.sh /etc/service/http/run
 #COPY apache2-run.sh /etc/service/http/run
#runit service permissions
 RUN chmod +x /etc/service/http/run
 
 #delete default html
 RUN rm /var/www/html/index.html
  
  # copy source file 
 COPY package/ /var/www/html/
 
EXPOSE 80
 ## /apache2 
#apt-cleanup
 RUN apt-get clean
 RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
 ENV STARTUP_SCRIPT=/usr/local/bin/start-up.sh
 COPY ./apache2-run.sh $STARTUP_SCRIPT
 RUN chmod +x $STARTUP_SCRIPT
 ENTRYPOINT $STARTUP_SCRIPT
