#!/bin/bash -x
sudo yum update -y
sudo curl -Lo /etc/yum.repos.d/go-repo.repos https://mirror.go-repo.io/centos/go-repo.repo
echo W2F6dXJlLWNsaV0KbmFtZT1BenVyZSBDTEkKYmFzZXVybD1odHRwczovL3BhY2thZ2VzLm1pY3Jvc29mdC5jb20veXVtcmVwb3MvYXp1cmUtY2xpCmVuYWJsZWQ9MQpncGdjaGVjaz0xCmdwZ2tleT1odHRwczovL3BhY2thZ2VzLm1pY3Jvc29mdC5jb20va2V5cy9taWNyb3NvZnQuYXNjCg== | base64 -d > azure-cli.repo
sudo yum install -y gcc make wget unzip which less openssh-clients openssl jq etcd
#sudo cp azure-cli.repo /etc/yum.repos.d/azure-cli.repo
#sudo yum install golang azure-cli python3-pip
#curl https://sdk.cloud.google.com > install.sh
#sudo bash ./install.sh --disable-prompts --install-dir=/usr/local/
#sudo ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
#sudo ln -s /usr/local/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil
#sudo ln -s /usr/local/google-cloud-sdk/bin/anthoscli /usr/local/bin/anthoscli
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
unzip -o awscliv2.zip
rm awscliv2.zip
sudo bash ./aws/install
#sudo curl -sSL https://get.docker.com | bash
#sudo usermod -a -G docker centos
#sudo usermod -a -G docker jenkins
#sudo systemctl enable docker --now
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
### Install kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl
### Install kubectx
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
### Install Helm
curl -sSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
curl -Lo /tmp/pxc.tar.gz https://github.com/portworx/pxc/releases/download/v0.35.0/pxc-v0.35.0.linux.amd64.tar.gz
cd /tmp && tar -zxvf /tmp/pxc.tar.gz
rm /tmp/pxc.tar.gz
sudo mv /tmp/pxc/kubectl-pxc /usr/local/bin/kubectl-pxc
sudo chmod +x /usr/local/bin/kubectl-pxc
alias pxctl='kubectl pxc pxctl'
#curl -Lo /tmp/argocd https://github.com/argoproj/argo-cd/releases/download/v2.3.1/argocd-linux-amd64
#chmod +x /tmp/argocd
#sudo mv /tmp/argocd /usr/local/bin
