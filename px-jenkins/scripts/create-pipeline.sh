#!/bin/bash -x

declare -a PipelineList =(
    "create-job eks-px-pipeline"
    "create-job gke-px-pipeline"
    "create-job argocd-server-tasks"
    "deploy-cassandra-db"
)

declare -a PathList =(
    "pipelines/eks-px-pipeline.xml"
    "pipelines/gke-px-pipeline.xml"
    "pipelines/argocd-pipeline.xml"
    "pipelines/cassandra-db-pipeline.xml"

)

for ((i=0;i<=${#PipelineList[@]};i++)); do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  ${PipelineList[i]} < /tmp/portworx-poc/px-jenkins/${PathList[i]}
done

#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job eks-px-pipeline < /tmp/portworx-poc/px-jenkins/pipelines/eks-px-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job gke-px-pipeline < /tmp/portworx-poc/px-jenkins/pipelines/gke-px-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job argocd-server-tasks < /tmp/portworx-poc/px-jenkins/pipelines/argocd-pipeline.xml
#java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job deploy-cassandra-db < /tmp/portworx-poc/px-jenkins/pipelines/cassandra-db-pipeline.xml

#sudo systemctl restart jenkins


