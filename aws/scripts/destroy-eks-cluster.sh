#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,Not proceeding further"
    exit 0
fi

echo "Proceeding to destroy EKS Cluster : $1"
EKS_CLUSTER_NAME=$1
NODE_TYPE=t3.large
FIRST_AWS_REGION=$2
NUMBER_OF_NODES=3


VPC_ID=$(eksctl utils describe-stacks --region $FIRST_AWS_REGION --cluster $EKS_CLUSTER_NAME | grep vpc- | cut -f 2 -d \")
PROFILE_ARN=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$VPC_ID" --region $FIRST_AWS_REGION --query Reservations[0].Instances[0].IamInstanceProfile.Arn --output text | cut -f 2 -d /)
ROLE_NAME=$(aws iam get-instance-profile --instance-profile-name $PROFILE_ARN --region $FIRST_AWS_REGION --query InstanceProfile.Roles[0].RoleName --output text)
INSTANCES=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$VPC_ID" --region $FIRST_AWS_REGION --query Reservations[].Instances[].InstanceId --output text)

VOLUMES=$(for j in $INSTANCES; do aws ec2 describe-volumes --region $FIRST_AWS_REGION --filters "Name=attachment.instance-id,Values=$j" "Name=tag:PWX_CLUSTER_ID,Values=px-cluster*" --query Volumes[].Attachments[].VolumeId --output text; done)

aws iam delete-role-policy --role-name $ROLE_NAME --policy-name px-eks-policy --region $FIRST_AWS_REGION
echo "Destroying EKS, in VPC name: $VPC_ID wait about 5 minutes (per cluster)"
eksctl delete cluster --region $FIRST_AWS_REGION --name $EKS_CLUSTER_NAME --wait >&/tmp/delete
echo "eks cluster deleted"

for j in $VOLUMES; do
  aws ec2 delete-volume --region $FIRST_AWS_REGION --volume-id $j
done

echo "Attached volumes deleted"
