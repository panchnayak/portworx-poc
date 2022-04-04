# px-rancher

Rancher K8s Management and Orchestration Platform Deployment on AWS.

This will Create a Quick Instances on AWS and you Can access it using the public IP address or DNS name of the Instance.

Install Terraform on your laptop or desktop

```
git clone https://github.com/panchnayak/portworx-poc.git
cd px-rancher
```
Edit the variable.tf file with your own default values

```
terraform init
terraform plan
terraform apply
```
get the IP address of the Instance created ,you can get it using

```
teeraform output
```

The default username for the rancher login page is "admin/adminPassword"

Then you can create your Rancher Kubernates Cluster as you like for portworx demo cluster

For now eks is tested.


## Create EKS Cluster for Portworx Deployment

```
1. Add your AWS credentials

### ![AWS Credential](/repository/px-rancher/images/aws-creds.jpg?raw=true "Add AWS Credential")

2. Create EKS Cluster using Rancher
   Provide the Cluster name and node group name
   After the creation of the NodeGroup, eidentify the role attached to it 
3. Open the Role attached to the NodeGroup, then search and add a policy named "rancher-portworx-policy" to the role.

![EKS NodeGroup Role](/px-rancher/images/eks-nodegroup-role.jpg?raw=true "EKS NodeGroup Role attached")

Go back to Rancher Dashboard and download the kubeconfig file or open the 
4. Create an account on https://central.portworx.com/
5. Create a portworx specs to be applied to the Kubernetes cluster

You can download the specs and edit them as you need before applying they to the cluster

5. Apply the Specs using kubectl command as the follwoing example

the following is to install portworx operator

```
kubectl apply -f 'https://install.portworx.com/2.9?comp=pxoperator'
```
6. Apply the specs as the following

```
kubectl apply -f your-eks-specs-downloaded-from-central-portworx-com.yaml

```

Watch the pods get created using the following 

```
watch kubectl get pods -A
```

Or go to your 
*Note - Confirm the portworx-api pods are running

Please inform me if you face any problem.

