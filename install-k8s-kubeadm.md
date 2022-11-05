# VM Preparation

sudo apt update
sudo apt -y full-upgrade
[ -f /var/run/reboot-required ] && sudo reboot -f

## Disable swap

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

### Install kubelet, kubeadm and kubectl

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

sudo apt-get install -y kubelet=1.24.6-00 kubeadm=1.24.6-00 kubectl=1.24.6-00
sudo apt-mark hold kubelet kubeadm kubectl


Enable kernel modules and configure sysctl.

# Enable kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Add some settings to sysctl
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system

## CRI-O Installation Instructions

# Reload sysctl
sudo sysctl --system

# Add Cri-o repo
sudo su -
OS="xUbuntu_20.04"
VERSION=1.24

echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -

# Install CRI-O
sudo apt update
sudo apt install cri-o cri-o-runc

# Update CRI-O CIDR subnet
sudo sed -i 's/10.85.0.0/192.168.0.0/g' /etc/cni/net.d/100-crio-bridge.conf

# Start and enable Service
sudo systemctl daemon-reload
sudo systemctl restart crio
sudo systemctl enable crio
sudo systemctl status crio

sudo -i

Setup cgroup driver

edit the file /etc/crio/crio.conf with the following

vi /etc/crio/crio.conf

[crio.runtime]
conmon_cgroup = "pod"
cgroup_manager = "cgroupfs"

[crio.image]
pause_image="registry.k8s.io/pause:3.6"

or create a new file

/etc/crio/crio.conf.d/02-cgroup-manager.conf

[crio.runtime]
conmon_cgroup = "pod"
cgroup_manager = "cgroupfs"

[crio.image]
pause_image="registry.k8s.io/pause:3.6"

## Update and Install Packages

sudo apt-get install -y jq
local_ip="$(ip --json a s | jq -r '.[] | if .ifname == "eth1" then .addr_info[] | if .family == "inet" then .local else empty end else empty end')"
cat > /etc/default/kubelet << EOF
KUBELET_EXTRA_ARGS=--node-ip=$local_ip
EOF

export CLUSTER_ENDPOINT=my-cluster-endpoint
export IPADDR=192.168.1.131
export POD_CIDR=10.10.0.0/16
export NODENAME=$(hostname -s)

sudo kubeadm config images pull --cri-socket unix:///var/run/crio/crio.sock

sudo kubeadm init --apiserver-advertise-address=$IPADDR  --pod-network-cidr=$POD_CIDR --apiserver-cert-extra-sans=$CLUSTER_ENDPOINT --control-plane-endpoint=192.168.1.131 --upload-certs --node-name $NODENAME --ignore-preflight-errors Swap

# Install network plugin on Master


kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

kubectl delete -f https://docs.projectcalico.org/manifests/tigera-operator.yaml 
kubectl delete -f https://docs.projectcalico.org/manifests/custom-resources.yaml

### Remove Kubernetes by kubeadm

kubeadm reset






