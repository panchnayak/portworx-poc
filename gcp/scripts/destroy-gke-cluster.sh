
#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,Not proceeding further"
    exit 0
fi

echo "Proceeding to destroy GKE Cluster : $1"

GKE_CLUSTER_NAME=$1
AWS_TYPE=t3.large
GCP_ZONE=$2
#SECOND_AWS_REGION=$3

gcloud container clusters delete ${GKE_CLUSTER_NAME} --zone ${GCP_ZONE} --quiet

echo "GKE Cluster deleted"
