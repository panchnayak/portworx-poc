#!/bin/bash -x

sudo yum install java-11-openjdk-devel -y
sudo yum install daemonize jenkins -y
J_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
sudo ln -s $J_HOME /usr/lib/jvm/openjdk11
export JAVA_HOME=/usr/lib/jvm/openjdk11
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
export PATH=$PATH:$JAVA_HOME/bin:.
sudo systemctl enable jenkins --now