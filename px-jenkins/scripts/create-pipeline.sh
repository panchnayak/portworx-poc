#!/bin/bash -x

declare -a PipelineList=(
    "eks-px-pipeline"
    "gke-px-pipeline"
    "argocd-server-tasks"
    "deploy-cassandra-db"
    "update-argocd-password"
)

declare -a PathList=(
    "eks-px-pipeline.xml"
    "gke-px-pipeline.xml"
    "argocd-pipeline.xml"
    "cassandra-db-pipeline.xml"
    "update-argocd-pass.xml"

)

for ((i=0;i<=${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done

#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job eks-px-pipeline < /tmp/portworx-poc/px-jenkins/pipelines/eks-px-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job gke-px-pipeline < /tmp/portworx-poc/px-jenkins/pipelines/gke-px-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job argocd-server-tasks < /tmp/portworx-poc/px-jenkins/pipelines/argocd-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job deploy-cassandra-db < /tmp/portworx-poc/px-jenkins/pipelines/cassandra-db-pipeline.xml

#sudo systemctl restart jenkins


