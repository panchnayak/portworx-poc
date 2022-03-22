#!/bin/bash -x


java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job eks-px-pipeline < ./px-jenkins/pipelines/eks-px-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job gke-px-pipeline < ./px-jenkins/pipelines/gke-px-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job argocd-server-tasks < ./px-jenkins/pipelines/argocd-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job deploy-cassandra-db < ./px-jenkins/pipelines/cassandra-db-pipeline.xml

#sudo systemctl restart jenkins


