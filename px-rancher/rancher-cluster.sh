#!/bin/bash -x

rancher_ip="$1"
admin_password="adminPassword"
rancher_version="v2.6.3"
k8s_version="v1.20.10-rancher1-1"
curlimage="appropriate/curl"
jqimage="stedolan/jq"

for image in $curlimage $jqimage "rancher/rancher:${rancher_version}"; do
  until sudo docker inspect $image > /dev/null 2>&1; do
    sudo docker pull $image
    sleep 2
  done
done

sudo docker run -d --restart=unless-stopped -p 80:80 -p 443:443 -v /opt/rancher:/var/lib/rancher --privileged rancher/rancher:${rancher_version}

# wait until rancher server is ready
while true; do
  sudo docker run --rm --net=host $curlimage -sLk https://127.0.0.1/ping && break
  sleep 5
done

# Check if there's a bootstrap password in the log
CONTAINERID=$(sudo docker ps | grep "rancher/rancher:${rancher_version}" | cut -d " " -f 1)
BOOTSTRAP_PASSWORD=$(sudo docker logs "$CONTAINERID" 2>&1 | grep "Bootstrap Password:" | sed -n 's/.*: \(.*\)$/\1/p')
if [ -z "$BOOTSTRAP_PASSWORD" ]; then
    BOOTSTRAP_PASSWORD="admin"
fi

# Login
while true; do
    LOGINRESPONSE=$(sudo docker run \
        --rm \
        --net=host \
        $curlimage \
        -s "https://127.0.0.1/v3-public/localProviders/local?action=login" -H 'content-type: application/json' --data-binary '{"username":"admin","password":"'$BOOTSTRAP_PASSWORD'"}' --insecure)
    LOGINTOKEN=$(echo $LOGINRESPONSE | sudo docker run --rm -i $jqimage -r .token)

    if [ "$LOGINTOKEN" != "null" ]; then
        break
    else
        sleep 5
    fi
done

# Change password
echo "Changing Password"
sudo docker run --rm --net=host $curlimage -s 'https://127.0.0.1/v3/users?action=changepassword' -H 'content-type: application/json' -H "Authorization: Bearer $LOGINTOKEN" --data-binary '{"currentPassword":"'$BOOTSTRAP_PASSWORD'","newPassword":"'$admin_password'"}' --insecure

# Create API key
echo "Create API key"
APIRESPONSE=$(sudo docker run --rm --net=host $curlimage -s 'https://127.0.0.1/v3/token' -H 'content-type: application/json' -H "Authorization: Bearer $LOGINTOKEN" --data-binary '{"type":"token","description":"automation"}' --insecure)

# Extract and store token
echo "Extract and store token"
APITOKEN=`echo $APIRESPONSE | sudo docker run --rm -i $jqimage -r .token`

# Configure server-url
echo "Configure server-url"

RANCHER_SERVER="https://${rancher_ip}"
sudo docker run --rm --net=host $curlimage -s 'https://127.0.0.1/v3/settings/server-url' -H 'content-type: application/json' -H "Authorization: Bearer $APITOKEN" -X PUT --data-binary '{"name":"server-url","value":"'$RANCHER_SERVER'"}' --insecure

while true; do
  sudo docker run --rm --net=host $curlimage -sLk https://127.0.0.1/ping && break
  sleep 5
done

# Create cluster
CLUSTERRESPONSE=$(sudo docker run --rm --net=host $curlimage -s 'https://127.0.0.1/v3/cluster' -H 'content-type: application/json' -H "Authorization: Bearer $APITOKEN" --data-binary '{"dockerRootDir":"/var/lib/docker","enableNetworkPolicy":false,"type":"cluster","rancherKubernetesEngineConfig":{"kubernetesVersion":"'$k8s_version'","addonJobTimeout":30,"ignoreDockerVersion":true,"sshAgentAuth":false,"type":"rancherKubernetesEngineConfig","authentication":{"type":"authnConfig","strategy":"x509"},"network":{"options":{"flannelBackendType":"vxlan"},"plugin":"canal","canalNetworkProvider":{"iface":"eth1"}},"ingress":{"type":"ingressConfig","provider":"nginx"},"monitoring":{"type":"monitoringConfig","provider":"metrics-server"},"services":{"type":"rkeConfigServices","kubeApi":{"podSecurityPolicy":false,"type":"kubeAPIService"},"etcd":{"creation":"12h","extraArgs":{"heartbeat-interval":500,"election-timeout":5000},"retention":"72h","snapshot":false,"type":"etcdService","backupConfig":{"enabled":true,"intervalHours":12,"retention":6,"type":"backupConfig"}}}},"localClusterAuthEndpoint":{"enabled":true,"type":"localClusterAuthEndpoint"},"name":"quickstart"}' --insecure)

# Extract clusterid to use for generating the docker run command
CLUSTERID=`echo $CLUSTERRESPONSE | sudo docker run --rm -i $jqimage -r .id`

# Generate registrationtoken
sudo docker run --rm --net=host $curlimage -s 'https://127.0.0.1/v3/clusterregistrationtoken' -H 'content-type: application/json' -H "Authorization: Bearer $APITOKEN" --data-binary '{"type":"clusterRegistrationToken","clusterId":"'$CLUSTERID'"}' --insecure