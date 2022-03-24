#!/bin/bash -x


declare -a PipelineList=(
   "1-Execute-kubectl-commands-for-K8s" 
   "2-Deploy-Independent-AWS-EKS"  
   "3-Deploy-Independent-GCP-GKE"  
   "4-Complete-Metro-Cluster-Demo"  
   "5-Deploy-Cassandra-DB-On-Existing-K8s" 
   "6-Portworx-Backup-Demo" 
   )

declare -a PathList=(
   "kubectl-command.xml" 
   "eks-px.xml"  
   "gke-px.xml"  
   "metro-cluster.yaml" 
   "cassandra-db.xml"  
   "backup-demo.xml"
   )

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done


