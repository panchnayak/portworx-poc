#!/bin/bash -x

if [ $# -lt 2 ]
  then
    echo "Error: No Cluster name supplied please supply the Portworx Cluster name as the first argument,and Namespace as 2nd argument and Region name in the third argument, Not going ahead"
    exit 0
fi

PX_CLUSTER_NAME=$1
PX_NAMESPACE=$2

echo "Proceeding to create Portworx Cluster $1"

kubectl apply -f - <<EOF
# SOURCE: https://install.portworx.com/?operator=true&mc=false&ns=portworx&b=true&kd=type%3Dgp2%2Csize%3D150&s=%22type%3Dgp2%2Csize%3D150%22&c=px-cluster-8ffdf101-1416-4abc-9052-8657a7883fa5&eks=true&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true
kind: StorageCluster
apiVersion: core.libopenstorage.org/v1
metadata:
  name: $PX_CLUSTER_NAME
  namespace: $PX_NAMESPACE
  annotations:
    portworx.io/install-source: "https://install.portworx.com/?operator=true&mc=false&ns=portworx&b=true&kd=type%3Dgp2%2Csize%3D150&s=%22type%3Dgp2%2Csize%3D150%22&c=px-cluster-8ffdf101-1416-4abc-9052-8657a7883fa5&eks=true&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true"
    portworx.io/is-eks: "true"
spec:
  deleteStrategy:
    type: UninstallAndWipe
  image: portworx/oci-monitor:2.12.0
  imagePullPolicy: Always
  kvdb:
    internal: true
  cloudStorage:
    deviceSpecs:
    - type=gp2,size=150
    kvdbDeviceSpec: type=gp2,size=150
  secretsProvider: k8s
  stork:
    enabled: true
    args:
      webhook-controller: "true"
  autopilot:
    enabled: true
  csi:
    enabled: true
  monitoring:
    prometheus:
      enabled: true
      exportMetrics: true
EOF


