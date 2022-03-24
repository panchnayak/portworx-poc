#!/bin/bash -x


declare -a PipelineList=("1-Execute-kubectl-commands-for-EKS" "2-EKS-K8s-Cluster-Pipeline"  "3-ArgoCD-Related-Tasks" "4-Deploy-Cassandra DB" "5-GKE-Cluster-Pipeline")
declare -a PathList=("kubectl-command.xml" "eks-px-pipeline.xml"  "argocd-pipeline.xml" "cassandra-db-pipeline.xml" "gke-px-pipeline.xml")

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done


