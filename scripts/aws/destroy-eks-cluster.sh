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

eksctl delete cluster -f - <<EOF
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: $EKS_CLUSTER_NAME
  region: $AWS_REGION
  version: "1.23"
managedNodeGroups:
  - name: $NODE_GROUP_NAME
    instanceType: t3.large
    minSize: 3
    maxSize: 3
    volumeSize: 20
    #ami: auto
    amiFamily: AmazonLinux2
    labels: {role: worker, "portworx.io/node-type": "storage"}
    tags:
      nodegroup-role: worker
    iam:
      attachPolicyARNs:
        - arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
        - arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
        - arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
        - arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess
        - arn:aws:iam::803113055342:policy/rancher-portworx-policy
        - arn:aws:iam::803113055342:policy/pn-portworx
      withAddonPolicies:
        imageBuilder: true
        autoScaler: true
        ebs: true
        fsx: true
        efs: true
        albIngress: true
        cloudWatch: true
availabilityZones: [ 'us-east-1a', 'us-east-1b', 'us-east-1c' ]
EOF

echo "EKS Cluster $1 Created in Region $2"
