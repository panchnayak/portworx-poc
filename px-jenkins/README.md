## Portworx POCs on Kubernetes clusters

This repository is for creating Kubernetes clusters on various Cloud environments and conducting Portworx POC.

## Quickstart Procedure

Install terraform on your laptop or desktop

clone this repository
```
git clone https://github.com/panchnayak/portworx-poc.git
cd portworx-poc/px-jenkins
```
Edit the variable.tf file to change the dafault names and values for your environmnt.

```
vi variable.tf

edit the default names and values

terraform init
teraform plan
terraform apply
```

![Terraform Apply](/px-jenkins/images/terraform-apply.jpg?raw=true "Terraform Apply")

This will create a new VPC and create a Jenkins Instance on the VPC. go and have a cup of coffee, first time it ll take some time to configure all the packages needed for Jenkisn to able to build the pipelines for different scenarios and use cases.

So that you can focus on the Application Use cases rather than Jenkins and other tools instalation.

Wait for the Instance to be completley running and then find the IP of the Instance to access the jenkins server login page.

## Accessing and using Jenkins Server Instance

Get the IP address of Jenkins Server

```
terraformf output public_ip

```

You can acces the Jenkins login page by accesing the http://$JENKINS_IP_ADDRESS:8080/

Login with the following

```
default username and password as "admin:password"
```

They it will ask you to install Suggested plugins, you can click to install the Suggested plugins. Admin user is crated or you so no need to create it again.

Then confirm and set the Jenkins URL and start using Jenkins, You can see there are multiple pielines already created for you to use.

You are ready to go. Before running these pipeline only one thing you have to do configure your cloud credentials on jenkins.

Here is an Example of AWS Credntial using AWS plugin, AWS plugin for jenkins is already installed for you.

## Create AWS Credential for Jenkins to use

Jenkins needs your AWS credential to use it for creating Instances or EKS cluster on AWS

## Using the Pipeline on Jenkins

1.First Pipeline is for ruuning eksctl command on your Kubernetes Cluster created by this Jenkins Server
2.....

Clieck on EKS Pipeline to create the EKS cluster on AWS

Happy Demoing of Portworx Software.


