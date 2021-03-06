#!/bin/bash -x

if [ $# -lt 3 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,and NodeGroup name as 2n argument and Region name in the third argument, Not going ahead"
    exit 0
fi

echo "Proceeding to crate EKS Cluster : $1 in Region $3"
EKS_CLUSTER_NAME=$1
NODE_GROUP_NAME=$2
NODE_TYPE=t3.large
AWS_REGION=$3
#SECOND_AWS_REGION=$3
NUMBER_OF_NODES=3
eksctl create cluster --region $AWS_REGION --nodes $NUMBER_OF_NODES --node-type $NODE_TYPE --name $EKS_CLUSTER_NAME  --nodegroup-name $NODE_GROUP_NAME
VPC_ID=$(eksctl utils describe-stacks --region $AWS_REGION --cluster $EKS_CLUSTER_NAME | grep vpc- | cut -f 2 -d \")
PROFILE_ARN=$(aws ec2 describe-instances --filters "Name=vpc-id,Values=$VPC_ID" --region $AWS_REGION --query Reservations[0].Instances[0].IamInstanceProfile.Arn --output text | cut -f 2 -d /)
ROLE_NAME=$(aws iam get-instance-profile --instance-profile-name $PROFILE_ARN --region $AWS_REGION --query InstanceProfile.Roles[0].RoleName --output text)
cat <<EOF >/tmp/role.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "ec2:AttachVolume",
                "ec2:DetachVolume",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteTags",
                "ec2:DeleteVolume",
                "ec2:DescribeTags",
                "ec2:DescribeVolumeAttribute",
                "ec2:DescribeVolumesModifications",
                "ec2:DescribeVolumeStatus",
                "ec2:DescribeVolumes",
                "ec2:DescribeInstances",
                "ec2:DeleteSnapshot",
                "ec2:DescribeInstances",
                "ec2:CreateTags",
                "ec2:CreateSnapshots",
                "ec2:DescribeVolumes",
                "ec2:CreateSnapshot",
                "ec2:DescribeRegions",
                "ec2:DescribeSnapshots",
                "ec2:CreateVolume",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListBucket",
                "s3:GetBucketAcl",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:ListAllMyBuckets",
                "s3:GetObjectVersionAcl",
                "s3:DeleteObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
aws iam put-role-policy --role-name $ROLE_NAME --policy-name px-eks-policy --policy-document file:///tmp/role.json --region $AWS_REGION

echo "EKS Cluster $1 Created in Region $2"
