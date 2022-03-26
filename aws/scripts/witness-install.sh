#!/bin/bash
​
PX_DOCKER_IMAGE=portworx/px-enterprise:2.7.0
​
function usage()
{
    echo "Install Portworx as a witness node"
    echo ""
    echo "./install-witness.sh"
    echo "--help"
    echo "--cluster-id=$CLUSTER_ID"
    echo "--etcd=$ETCD"
    echo "--docker-image=$PX_DOCKER_IMAGE"
    echo ""
}
​
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        --help)
            usage
            exit
            ;;
        --cluster-id)
            CLUSTER_ID=$VALUE
            ;;
        --docker-image)
            PX_DOCKER_IMAGE=$VALUE
            ;;
        --etcd)
            ETCD=$VALUE
            ;;	
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done
​
sudo docker run --entrypoint /runc-entry-point.sh \
    --rm -i --privileged=true \
    -v /opt/pwx:/opt/pwx -v /etc/pwx:/etc/pwx \
    $PX_DOCKER_IMAGE
​
/opt/pwx/bin/px-runc install -k $ETCD -c $CLUSTER_ID --cluster_domain witness -a
​
sudo systemctl daemon-reload
sudo systemctl enable portworx
sudo systemctl start portworx
​
watch -n 1 --color /opt/pwx/bin/pxctl --color status