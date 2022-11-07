#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No usename and password Provided, please supply the user name as the first argument,and password for jenkins as 2n argument, Not going ahead"
    exit 0
fi


declare -a PipelineList=(
   "Day-1-Deploy-or-Destroy-AWS-EKS-Cluster"
   "Day-1-Deploy-or-Destroy-GCP-GKE-Cluster"
   "Day-1-Get-Kubeconfig-file-for-K8S-Cluster"
   "Day-1-Execute-kubectl-commands-for-K8s" 
   "Day-1-Deploy-or-Destroy-Portworx-on-the-Kubernetes-Cluster"
   "Day-1-Deploy-ETCD-Single-Node-Cluster"
   "Day-1-Deploy-or-Destroy-Portworx-on-MultiCloud-Env"
   "Day-1-Complete-or-Destroy-Metro-DR-Cluster-Demo"  
   "Day-2-Create Petclinic Application"
   "Day-2-Create=StorageClass"
   "Day-2-Developr Create Volumes-for-Apps"
   "Day-2-Deploy-or-Destroy-Cassandra-DB-On-Existing-K8s"
   "Day-3-Deploy-or-Destroy-Px-Backup-Demo" 
   )

declare -a PathList=(
   "eks-px.xml"
   "gke-px.xml"
   "get-kubeconfig.xml"
   "kubectl-command.xml"
   "portworx-install.xml"  
   "etcd-cluster.xml"
   "multicloud-cluster.xml"
   "metro-cluster.xml"
   "cassandra-db.xml"
   "px-petclinic.xml"
   "px-storage-class.xml"
   "px-volume.xml"
   "px-backup-demo.xml"
   )

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/scripts/jenkins/pipelines/${PathList[i]}
done


