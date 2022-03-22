#!/bin/bash -x

declare -a PluginList=(
    "blueocean"
    "gitea" 
    "kubernetes" 
    "git"
    "github" 
    "docker-workflow"
    "pipeline-multibranch-defaults" 
    "blueocean" 
    "pipeline-aws"
    "google-kubernetes-engine"
    "google-compute-engine"
    "gcp-secrets-manager-credentials-provider"
    "openshift-k8s-credentials"
    "openshift-client"
    "vsphere-cloud"
    "kubernetes-cli"
)

curl -LO http://localhost:8080/jnlpJars/jenkins-cli.jar

for plugin in ${PluginList[@]}; do
   java -jar jenkins-cli.jar -auth $1:$2 -s http://localhost:8080/ install-plugin $plugin

done


