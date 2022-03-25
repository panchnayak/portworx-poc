#!/bin/bash -x


declare -a PipelineList=(
   "1-Execute-kubectl-commands-for-K8s" 
   "2-Deploy-Independent-AWS-EKS"  
   "3-Deploy-Independent-GCP-GKE"
   "4-Deploy-ETCD-Cluster"  
   "5-Install-Portworx-on-MultiCloud-Env"
   "6-Complete-Metro-Cluster-Demo"  
   "7-Deploy-Cassandra-DB-On-Existing-K8s" 
   "8-Portworx-Backup-Demo" 
   )

declare -a PathList=(
   "kubectl-command.xml" 
   "eks-px.xml"  
   "gke-px.xml"
   "etcd-cluster.xml"  
   "multicloud-cluster.xml"
   "metro-cluster.xml" 
   "cassandra-db.xml"  
   "backup-demo.xml"
   )

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done


