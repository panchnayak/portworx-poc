For developing Cloud Native applications Kubertnetes is a very developer friendly environment.
Developers around the world works with various Devops tools and create CI/CD pipeline to develop and deploy cloud native applications on kubernetes on any Cloud environment.

The main advantages of working with kubernetes is developers don't have to think about infrastructure for deployment.
They simply code the application and code the infrastructure to deploy these applications using the kubernetes deplyment descriptors, normally in a yaml format.

But as we know kubernetes can deploy, manage and orchestrate the stateless containers very well, i.e provide a runtime including processor and memory to run the stateless container.What about the Networking and Storage ?

Kubernetes dependent on verious modules and plugins for orchestration of Network and Storage.

## Kubernetes Networking

There are 4 different distict problems to be solved by Kubernetes

1. Inter-Container (container-to-container) communications
2. Inter-pod (Pod-to-Pod) communications
3. Pod-to-Service communications
4. External-to-Service communications

## Kubernet4s Storage

How storage is managed by Kubernetes, what are the different challenges to be solved ?

This is what is our interest in the Article.

This repository is for creating Kubernetes clusters on various Cloud environments and conducting Portworx POC using Jenkins

## Portworx POCs on Kubernetes clusters

This repository is for conducting Portworx POCs on Kubernetes clusters on various Cloud environments.

There are different ways one can Create and Manage the Kubernetes Clusters, please go to individual directories and read the READMEs.

1.Using Jenkins
2.Using Rancher

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

This will create a  new VPC and create a Jenkins Instance on the VPC.
It ll take some time to create the Instance and deploy jenkins and the required oftware to build the portworx related pipelines.

Wait for the Instance to be completley running and then find the IP of the Instance to access the jenkins server login page.

## Accessing and using Jenkins Server Instance

Get the IP address of Jenkins Server

```
tf output public_ip

```

You can acces the Jenkins login page by accesing the http://$JENKINS_IP_ADDRESS:8080/

Login with the following

```
default username and password as "admin:password"
```

They it will ask you to install Suggested plugins, you can click to install the Suggested plugins.

Then set the Jenkins URL and start using Jenkins

You can see there are multiple pielines already created for you to use.

## Create AWS Credential for Jenkins to use

Jenkins needs your AWS credential to use it for creating Instances or EKS cluster on AWS

## Using the Pipeline on Jenkins

1.First Pipeline is for ruuning eksctl command on your Kubernetes Cluster created by this Jenkins Server
2.....

Clieck on EKS Pipeline to create the EKS cluster on AWS

Happy Demoing of Portworx Software.


