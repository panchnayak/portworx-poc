
#!/bin/bash -x

if [ $# -lt 3 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,and Region name in the second argument, Not going ahead"
    exit 0
fi

GKE_CLUSTER_NAME=$1
AWS_TYPE=t3.large
GCP_ZONE=$2
#SECOND_AWS_REGION=$3
NUMBER_OF_NODES=$3

echo "Proceeding to crate GKE Cluster : $1 in Zone $2"

gcloud auth activate-service-account pnayak-poc-sa@pure-anthos.iam.gserviceaccount.com --key-file=/var/lib/jenkins/pure-anthos-f3b8cc24af2b.json
gcloud config set project pure-anthos


gcloud container clusters create ${GKE_CLUSTER_NAME} \
   --zone ${GCP_ZONE} --disk-type=pd-ssd --disk-size=100GB \
   --labels=poc=panch_gkekms --machine-type=n2-standard-4 \
   --num-nodes=$NUMBER_OF_NODES} --image-type ubuntu \
   --scopes compute-rw,storage-ro --enable-autoscaling \
   --max-nodes=3 --min-nodes=3

echo "GKE Cluster $1 Created in Region $2"

echo "preparing for portworx software instalation"

/tmp/scripts/prepare-gke-cluster.sh

