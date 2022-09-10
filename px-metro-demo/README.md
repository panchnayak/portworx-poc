### Install separate KVDB node

### Script to install Separate KVDB

#!/bin/bash

sudo yum update -y
curl -o //home/ec2-user/witness-install.sh https://raw.githubusercontent.com/panchnayak/portworx-poc/main/aws/scripts/witness-install.sh
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
docker run -d --restart unless-stopped -v /usr/share/ca-certificates/:/etc/ssl/certs -p 2382:2382 \
 --name etcd quay.io/coreos/etcd:latest \
 /usr/local/bin/etcd \
 -name etcd0 \
 -auto-compaction-retention=3 -quota-backend-bytes=8589934592 \
 -advertise-client-urls http://$(hostname -i):2382 \
 -listen-client-urls http://0.0.0.0:2382


### Install witness node

Download the script witness-install.sh


./witness-install.sh --cluster-id=px-metro-cluster  --etcd="etcd:http://10.10.16.223:2382"

Install operator

kubectl apply -f 'https://install.portworx.com/2.10?comp=pxoperator'

### Cluster Pairing

Generate ClusterPair Speck in Remote Cluster

storkctl generate clusterpair -n portworx remotecluster | sed '/insert_storage_options_here/c\' > cp.yaml

kubectl -n portworx patch stc px-metro-cluster --type merge -p='{"spec":{"stork":{"image":"openstorage/stork:2.11.3"}}}'


### Test procedure

pxctl cluster describe 
storkctl deactivate clusterdomain cluster-1
storkctl get custordomainstatus
storkctl activate migrations
