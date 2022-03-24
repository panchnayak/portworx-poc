#!/bin/bash -x


declare -a PipelineList=(
   "1-Execute-kubectl-commands-for-EKS" 
   "2-EKS-K8s-Cluster-Pipeline"  
   "3-GKE-Cluster-Pipeline"  
   "4-Deploy-Metro-Cluster"  
   "5-Deploy-Cassandra-DB" 
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


