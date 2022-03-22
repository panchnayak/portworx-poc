#!/bin/bash -x


java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job eks-px-pipeline < ./scripts/eks-px-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job gke-px-pipeline < ./scripts/gke-px-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job argocd-server-tasks < ./scripts/argocd-pipeline.xml
java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080  create-job deploy-cassandra-db < ./scripts/cassandra-db-pipeline.xml

#sudo systemctl restart jenkins


