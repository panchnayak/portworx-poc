#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No usename and password Provided, please supply the user name as the first argument,and password for jenkins as 2n argument, Not going ahead"
    exit 0
fi


declare -a PipelineList=(
   "Day-1-1-Deploy-or-Destroy-AWS-EKS-Cluster"
   "Day-1-2-Get-Kubeconfig-file-for-K8S-Cluster"
   "Day-1-3-Execute-kubectl-commands-for-K8s" 
   "Day-1-4-Deploy-or-Destroy-Portworx-on-the-Kubernetes-Cluster"
   "Day-1-5-Check-portworx-Cluster-Status"
   "Day-1-6-Deploy-ETCD-Single-Node-Cluster"
   "Day-2-1-Create-StorageClass"
   "Day-2-2-Create-Volumes-for-Apps"
   "Day-2-3-Create-Petclinic-Application"
   "Day-2-4-Deploy-or-Destroy-Cassandra-DB"
   "Day-3-1-Deploy-or-Destroy-Px-Backup" 
   "Day-3-2-Portworx-Operation-Demo"
   )

declare -a PathList=(
   "day-1-1-eks-px.xml"
   "day-1-2-get-kubeconfig.xml"
   "day-1-3-kubectl-command.xml"
   "day-1-4-portworx-install.xml"  
   "day-1-5-px-cluster-status.xml"
   "day-1-6-etcd-cluster.xml"
   "day-2-1-px-storage-class.xml"
   "day-2-2-px-volume.xml"
   "day-2-3-px-petclinic.xml"
   "day-2-4-cassandra-db.xml"
   "day-3-1-2px-backup.xml"
   "day-3-2-px-ops-demo.xml"
   )

for ((i=0;i<${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/scripts/jenkins/pipelines/${PathList[i]}
done


