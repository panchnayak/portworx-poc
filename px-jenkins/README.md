## Deploying Kubernetes Cluster and Portworx clusters using Jenkins



## Quickstart Procedure

Please follow this tutoral if you are new to terraform

https://learn.hashicorp.com/tutorials/terraform/install-cli

## Install Terraform on your laptop or desktop

Follow this if you want to install terraform CentOS or Redhat Linux
```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
```

Follow this if you want to install terraform on Ubuntu

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Follow this if you are on MacOS
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Now clone the repository using git

```
git clone https://github.com/panchnayak/portworx-poc.git
cd portworx-poc/px-jenkins
```
Edit the variable.tf file with your own default values

```
terraform init
terraform plan
terraform apply
```
![Terraform Apply](/px-jenkins/images/terraform-apply.jpg?raw=true "Terraform Apply")

Get the IP address of the Instance created ,you can get it using

```
terraform output public_ip
terraform output public_dns_name
```
![](/px-jenkins/images/public-ip.jpg?raw=true)

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

## Using the Pipeline on Jenkins

Following pipelines gets created when terraform finished installing jenkins.

- "Day-1-1-Deploy-or-Destroy-AWS-EKS-Cluster"
- "Day-1-2-Get-Kubeconfig-file-for-K8S-Cluster"
- "Day-1-3-Execute-kubectl-commands-for-K8s" 
- "Day-1-4-Deploy-or-Destroy-Portworx-Storage-Cluster"
- "Day-1-5-Check-portworx-Cluster-Status"
- "Day-1-6-Deploy-ETCD-Single-Node-Cluster"
- "Day-2-1-Create-StorageClass"
- "Day-2-2-Create-Volumes-for-Apps"
- "Day-2-3-Create-Petclinic-Application"
- "Day-2-4-Deploy-or-Destroy-Cassandra-DB"
- "Day-3-1-Deploy-or-Destroy-Px-Backup" 
- "Day-3-2-Portworx-Operation-Demo"

### Create AWS credential for jenkins to use in the pipelines

Before using the pipleines uou must create an AWS credential with your AWS secrets.Which you can get from your aws instalation.

cat ~/.aws/credentials
[default]
aws_access_key_id = XXXXXXXXXXXXXXX
aws_secret_access_key = XYXYXYXYXYXYXYYXYXYXYXYXYXYXYXYXY

Clieck on EKS Pipeline to create the EKS cluster on AWS

## Using the Pipeline on Jenkins

1.First Pipeline is for ruuning eksctl command on your Kubernetes Cluster created by this Jenkins Server
2.....

Clieck on EKS Pipeline to create the EKS cluster on AWS

Happy Demoing of Portworx Software.


