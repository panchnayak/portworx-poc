#!/bin/bash -x

if [ $# -lt 3 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,and NodeGroup name as 2n argument and Region name in the third argument, Not going ahead"
    exit 0
fi


EKS_CLUSTER_NAME=$1
NODE_GROUP_NAME=$2
NODE_TYPE=t3.large
AWS_REGION=$3
echo "Proceeding to crate EKS Cluster : $1 in Region $3"

eksctl delete cluster -f eks-demo-cluster-east.yaml

echo "EKS Cluster $1 Created in Region $2"