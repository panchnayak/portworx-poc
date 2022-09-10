#!/bin/bash

sudo yum update -y
curl -o //home/ec2-user/witness-install.sh https://raw.githubusercontent.com/panchnayak/portworx-poc/main/aws/scripts/witness-install.sh
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
