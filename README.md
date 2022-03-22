## Portworx POCs on Kubernetes clusters

This repository is for conducting Portworx POCs on Kubernetes clusters on various Cloud environments, using Jenkins Pipeline.

## Quickstart Procedure

Install terraform on your laptop or desktop

clone this repository
```
git clone https://github.com/panchnayak/portworx-poc.git
cd portworx-poc/aws
```
Edit the variable.tf file to change the names of your environmnt and names.

```
terraform init
teraform plan
terraform apply
```

This will create a  new VPC and create a Jenkins Instance on the VPC.
It ll take some time to create the Instance and deploy jenkins and the required oftware to build the portworx related pipelines.

Wait for the Instance to be completley running and then find the IP of the Instance to access the jenkins server login page.

## Accessing and using Jenkins Server Instance

You can acces the Jenkins login page by accesing the http://$JENKINS_IP_ADDRESS:8080/

After acessing the login page login with the default username and password as "admin:password"

They it will ask you to install some recommended plugins, you can click to install the recomended plugins.

Then set the Jenkins URL and start using Jenkins

You can see there are multiple pielines already created for you to use.

## Create AWS Credential for Jenkins to use

Jenkins needs your AWS credential to use it for creating Instances or EKS cluster on AWS

## Using the Pipeline on Jenkins

Clieck on EKS Pipeline to create the EKS cluster on AWS

Happy Demoing of Portworx Software.


