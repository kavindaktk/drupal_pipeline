#Base Image
 FROM 625650193469.dkr.ecr.us-east-1.amazonaws.com/drupal:base
  #Maintainer
 MAINTAINER Kavinda Thisara <kavindatk@gmail.com>;

  # copy source file 
 COPY build/ /opt/drupal/
