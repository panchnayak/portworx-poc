#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,and NodeGroup name as 2n argument and Region name in the third argument, Not going ahead"
    exit 0
fi


EKS_CLUSTER_NAME=$1
AWS_REGION=$2
echo "Proceeding to crate EKS Cluster : $1 in Region $2"

eksctl delete cluster -f ./scripts/aws/eks-demo-cluster-east.yaml

echo "EKS Cluster $1 Created in Region $2"