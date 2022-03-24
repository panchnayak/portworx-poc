#!/bib/bash -x

aws ec2 run-instances --image-id ami-0c02fb55956c7d316 --count 1 --instance-type t3.small \
    --key-name jenkins-keypair --security-group-ids $1 --subnet-id $2 --associate-public-ip-address \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=pnayak-singlenode-etcd}]' \
    --user-data file://aws/scripts/etcd-install.txt