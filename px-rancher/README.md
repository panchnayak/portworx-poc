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
2. Create EKS Cluster using Rancher
   Provide the Cluster name and node group name
   After the creation of the NodeGroup, eidentify the role attached to it 
3. Open the Role attached to the NodeGroup, then search and add a policy named "rancher-portworx-policy" to the role.
4. Create the Portworx Specs using https://central.portworx.com/

You can download the specs and edit them as you need before applying they to the cluster

5. Apply the Specs using kubectl command 

Watch the pods get created

```

Please inform me if you face any problem.

