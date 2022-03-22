#!/bin/bash -x

declare -a PipelineList=(
    "eks-px-pipeline"
    "gke-px-pipeline"
    "argocd-server-tasks"
    "deploy-cassandra-db"
)

declare -a PathList=(
    "eks-px-pipeline.xml"
    "gke-px-pipeline.xml"
    "argocd-pipeline.xml"
    "cassandra-db-pipeline.xml"
)

for ((i=0;i<=${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job ${PipelineList[i]} < /tmp/pipelines/${PathList[i]}
done


