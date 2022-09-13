#!/bin/bash -x
#login

#sudo sed -i '3,5 s/1.0/2.0/g' /var/lib/jenkins/config.xml
sudo sed -i -e 's/<jdks\/>/<jdks> <jdk> <name>java-11-openjdk<\/name> <home>\/usr\/lib\/jvm\/openjdk11<\/home>  <properties\/> <\/jdk> <\/jdks>/g' /var/lib/jenkins/config.xml
curl -LO http://localhost:8080/jnlpJars/jenkins-cli.jar