# Deploying Portworx on EKS using Rancher 

Portworx is a Software Definded Storage (SDS) overlay for any Container Orchestration Platform i.e any CNCF compliant Kubernetes (K8s) or Hashicorp Nomad application deployment platform.

Rancher is a K8s Cluster Management software, which can deploy and manage kubernetes on a veriety of Cloud and on-premise platforms.

## Deploying Rancher on AWS using Terraform 

This terraform script quickly creates a SingleNode Cluster Rancher Instances on AWS with a your own custom VPC,defined in the terraform variable file,and you Can access it using the public IP address or DNS name of the Instance.

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
cd portworx-poc/px-rancher
```
Edit the variable.tf file with your own default values

```
terraform init
terraform plan
terraform apply
```
Get the IP address of the Instance created ,you can get it using

```
terraform output public_ip
terraform output public_dns_name
```
Open the browser and go to the URL http://$PUBLIC_IP/ 

The default username for the rancher login page is "admin/adminPassword"

Now you can create your Kubernates Cluster as you like as your portworx demo cluster

For now AWS EKS is tested.

## Create EKS Cluster on rancher dashboard for Portworx Deployment

For this POS I assumed that the IAM polocy rancher-portworx-policy aldeard exists.

1. Add your AWS credentials

![AWS Credential](/px-rancher/images/aws-credential.jpg?raw=true "Add AWS Credential")

2. Create EKS Cluster using Rancher
   Provide the Cluster name and node group name and other details to create the EKS cluster.

![EKS NodeGroup Role](/px-rancher/images/eks-nodegroup-role.jpg?raw=true "EKS NodeGroup Role attached")

   After the creation of the NodeGroup on EKS , edentify the role attached to it 

![EKS NodeGroup Role](/px-rancher/images/eks-nodegroup-role.jpg?raw=true "EKS NodeGroup Role attached")

3. Open the Role attached to the NodeGroup, then search and add a policy named "px-policy-pnayak" or whatever name you have given in the variable file to the role.

![EKS Portworx Policy](/px-rancher/images/portworx-policy.jpg?raw=true "Attach Portworx Policy")

Go back to Rancher Dashboard and download the kubeconfig file or open the 

![EKS Kubeconfig](/px-rancher/images/rancher-kubeconfig-download.jpg?raw=true "Download EKS Kubeconfig")

## Generate portworx operator specifiction using central.portworx.com

4. Create an account on https://central.portworx.com
5. Login with your credentials and create portworx specs to be applied to the Kubernetes cluster

![Portworx Specs](/px-rancher/images/central-portworx.jpg?raw=true "Create Portwox Spec")
You can download the specs and edit them as you need before applying they to the cluster


## Portworx Installation on K8s Cluster provisioned by Rancher using kubectl from local terminal

6. Apply the Specs using kubectl command as the follwoing example

Apply the following to install portworx operator
```
kubectl --kubeconfig pnayak1.yml apply -f 'https://install.portworx.com/2.9?comp=pxoperator'  --insecure-skip-tls-verify
```
With the downloaded kubeconfig you can install the portworx opratior using the following command
```
kubectl --kubeconfig pnayak1.yml apply -f 'https://install.portworx.com/2.9?comp=pxoperator' --insecure-skip-tls-verify
```
7. Then Apply the specs as the following
With the downloaded kubeconfig you can install the portworx specs using the following command, there is a smaple specs file in the portworx directory, you can copy the downloaded specs in place of that or edit it.

```
kubectl --kubeconfig pnayak1.yml apply -f eks-px-portworx-specs.yaml --insecure-skip-tls-verify
```
Watch the pods get created using the following 

```
watch kubectl --kubeconfig pnayak1.yml get pods -n kube-system --insecure-skip-tls-verify
```

Or go to your Rancher Cluster View to see all the pods in the kube-system namespace or any other namespace which you have given in your portworx specs.

![App Pods](/px-rancher/images/rancher-eks-pods.jpg?raw=true "All Portworx Pods")

and the following

*Note - Confirm the portworx-api pods are running

![Rancher App Pods](/px-rancher/images/all-pods.jpg?raw=true "Rancher View All Pods")

See the Storage classes are available

![Portworx Storage Classses](/px-rancher/images/portwox-storage-class.jpg?raw=true "POrtworx Storage Classess Rancher View ")

Please inform me if you face any problem.

