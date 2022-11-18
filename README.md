# Introduction

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

## Kubernetes Storage

How storage is managed by Kubernetes, what are the different challenges to be solved ?

This is what is our interest in the Article.

This repository is for creating Kubernetes clusters on various Cloud environments and conducting Portworx POC using Jenkins

## Portworx POCs on Kubernetes clusters

This repository is for conducting Portworx POCs on Kubernetes clusters on various Cloud environments.

There are different ways one can Create and Manage the Kubernetes Clusters, please go to individual directories and read the READMEs.

1.Using Jenkins
2.Using Rancher

## Quickstart Procedure

Install terraform on your work machine,laptop or desktop, you can find the details to install terraform here.

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli

clone this repository
```
git clone https://github.com/panchnayak/portworx-poc.git
cd portworx-poc/px-jenkins
```
Edit the variable.tf file to change the dafault names and values for your environmnt.

```
vi variable.tf
```

Change the Following from their default values

- VPC name
- key-pair name from "jenkins-keypair" to your given name
- Role name from "jenkins_role" to your given name
- Instance profile name "jenkins-instance-profile" to your given name

```
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
terraform output public_ip

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

Following pipelines gets created when terraform finished installing jenkins.

-  "Day-1-1-Deploy-or-Destroy-AWS-EKS-Cluster"
   "Day-1-2-Get-Kubeconfig-file-for-K8S-Cluster"
   "Day-1-3-Execute-kubectl-commands-for-K8s" 
   "Day-1-4-Deploy-or-Destroy-Portworx-Storage-Cluster"
   "Day-1-5-Check-portworx-Cluster-Status"
   "Day-1-6-Deploy-ETCD-Single-Node-Cluster"
   "Day-2-1-Create-StorageClass"
   "Day-2-2-Create-Volumes-for-Apps"
   "Day-2-3-Create-Petclinic-Application"
   "Day-2-4-Deploy-or-Destroy-Cassandra-DB"
   "Day-3-1-Deploy-or-Destroy-Px-Backup" 
   "Day-3-2-Portworx-Operation-Demo"
   "Set-Kubernetes-Context"
   "Demo-Shared-V4-Volume"


### Create AWS credential for jenkins to use in the pipelines

Before using the pipleines uou must create an AWS credential with your AWS secrets.Which you can get from your aws instalation.
```
cat ~/.aws/credentials
[default]
aws_access_key_id = XXXXXXXXXXXXXXX
aws_secret_access_key = XYXYXYXYXYXYXYYXYXYXYXYXYXYXYXYXY
```
Clieck on EKS Pipeline to create the EKS cluster on AWS

Happy Demoing of Portworx Software.

## Some useful commands

### create AWS EKS cluster 
```
eksctl create cluster -f cluster-config-file.yaml
```
### get the kubeconfig file from an existing EKS cluster

```
eksctl utils write-kubeconfig --cluster "cluster-name" --region us-east-2
```
### Install portworx operator
```
kubectl apply -f 'https://install.portworx.com/2.12?comp=pxoperator&ns=portworx'
```
### get portworx cluster status
```
PX_POD=$(kubectl get pods -l name=portworx -o jsonpath='{.items[0].metadata.name}') 
 
alias pxctl='kubectl exec $PX_POD -- /opt/pwx/bin/pxctl' 
```



