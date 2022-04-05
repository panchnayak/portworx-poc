#!/bin/bash -x


declare -a PipelineList=(
   "1-Execute-kubectl-commands-for-K8s" 
   "2-Deploy-Independent-AWS-EKS-Cluster"  
   "3-Deploy-Independent-GCP-GKE-Cluster"
   "4-Deploy-ETCD-Single-Node-Cluster"  
   "5-Deploy-Portworx-on-the-Kubernetes-Cluster"
   "6-Deploy-Cassandra-DB-On-Existing-K8s" 
   "7-Complete-Metro-DR-Cluster-Demo"  
   "8-Portworx-Backup-Demo" 
   "9-Install-Portworx-on-MultiCloud-Env"
   )

declare -a PathList=(
   "kubectl-command.xml" 
   "eks-px.xml"  
   "gke-px.xml"
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


