#Base Image
 FROM 625650193469.dkr.ecr.us-east-1.amazonaws.com/drupal:base
  #Maintainer
 MAINTAINER Kavinda Thisara <kavindatk@gmail.com>;

  # copy source file 
 COPY package/ /opt/drupal/
 
EXPOSE 80
#CMD apachectl -D FOREGROUND
CMD bash
 ## /apache2 
#apt-cleanup
 #RUN apt-get clean
 #RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
