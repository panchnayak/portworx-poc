# Deploying Portworx on EKS using Rancher 

Portworx is a Software Definded Storage (SDS) overlay for any Container Orchestration Platform i.e any CNCF compliant Kubernetes (K8s) or Hashicorp Nomad application deployment platform.

Rancher is a K8s Cluster Management software, which can deploy and manage kubernetes on a veriety of Cloud and on-premise platforms.

# Deploying Rancher on AWS using Terraform 

This will Create a Quick Rancher SingleNode Cluster Instances on AWS and you Can access it using the public IP address or DNS name of the Instance.

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


1. Add your AWS credentials

![AWS Credential](/px-rancher/images/aws-credential.jpg?raw=true "Add AWS Credential")

2. Create EKS Cluster using Rancher
   Provide the Cluster name and node group name
   After the creation of the NodeGroup, eidentify the role attached to it 

![EKS NodeGroup Role](/px-rancher/images/eks-nodegroup-role.jpg?raw=true "EKS NodeGroup Role attached")

3. Open the Role attached to the NodeGroup, then search and add a policy named "rancher-portworx-policy" to the role.

![EKS Portworx Policy](/px-rancher/images/portworx-policy.jpg?raw=true "Attach Portworx Policy")

Go back to Rancher Dashboard and download the kubeconfig file or open the 
4. Create an account on https://central.portworx.com/
5. Create a portworx specs to be applied to the Kubernetes cluster

![Portworx Specs](/px-rancher/images/central-portworx.jpg?raw=true "Create Portwox Spec")
You can download the specs and edit them as you need before applying they to the cluster
![EKS Kubeconfig](/px-rancher/images/rancher-kubeconfig-download.jpg?raw=true "Download EKS Kubeconfig")

## Portworx Installation on K8s Cluster provisioned by Rancher Singlenode Cluster

6. Apply the Specs using kubectl command as the follwoing example

Apply the following to install portworx operator
```
kubectl apply -f 'https://install.portworx.com/2.9?comp=pxoperator'
```
With the downloaded kubeconfig you can install the portworx opratior using the following command
```
kubectl --kubeconfig pnayak1.yml apply -f 'https://install.portworx.com/2.9?comp=pxoperator' --insecure-skip-tls-verify
```
7. Apply the specs as the following
```
kubectl apply -f your-eks-specs-downloaded-from-central-portworx-com.yaml
```

With the downloaded kubeconfig you can install the portworx specs using the following command
```
kubectl --kubeconfig pnayak1.yml apply -f eks-portworx-specs.yaml --insecure-skip-tls-verify
```
Watch the pods get created using the following 

```
watch kubectl get pods -A
```

![App Pods](/px-rancher/images/rancher-eks-pods.jpg?raw=true "All Portworx Pods")

Or go to your Rancher Cluster View to see all the pods in the kube-system namespace, if you have not modified the namespace in the portworx specs.

*Note - Confirm the portworx-api pods are running

![Rancher App Pods](/px-rancher/images/all-pods.jpg?raw=true "Rancher View All Pods")

See the Storage classes are available

![Portworx Storage Classses](/px-rancher/images/portwox-storage-class.jpg?raw=true "POrtworx Storage Classess Rancher View ")

Please inform me if you face any problem.

