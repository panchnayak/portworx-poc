#!/bin/bash -x


declare -a PipelineList=(
   "1-Deploy-or-Destroy-AWS-EKS-Cluster"  
   "2-Deploy-or-Destroy-GCP-GKE-Cluster"
   "3-Get-Kubeconfig-file-for-K8S-Cluster"
   "4-Execute-kubectl-commands-for-K8s" 
   "5-Deploy-ETCD-Single-Node-Cluster"  
   "6-Deploy-or-Destroy-Portworx-on-the-Kubernetes-Cluster"
   "7-Deploy-or-Destroy-Cassandra-DB-On-Existing-K8s" 
   "8-Complete-or-Destroy-Metro-DR-Cluster-Demo"  
   "9-Portworx-or-Destroy-Backup-Demo" 
   "10-Deploy-or-Destroy-Portworx-on-MultiCloud-Env"
   )

declare -a PathList=(
   "eks-px.xml"  
   "gke-px.xml"
   "get-kubeconfig.xml"
   "kubectl-command.xml"
   "etcd-cluster.xml"  
   "portworx-install.xml"
   "cassandra-db.xml" 
   "metro-cluster.xml"
   "backup-demo.xml"
    "multicloud-cluster.xml"
   )

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done


