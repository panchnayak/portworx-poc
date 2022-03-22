#!/bin/bash -x
if [ $# -lt 2 ]
  then
    echo "Error: No Cluster name supplied please supply the Cluster name as the first argument,and Region name in the second argument, Not going ahead"
    exit 0
fi

echo "Creating ClusterRoleBinding "

gcloud info --format='value(config.account)'

kubectl create clusterrolebinding pn-px-cluster-admin-binding  --clusterrole=cluster-admin --user=`gcloud info --format='value(config.account)'`

newServiceAccount=pnayak-poc-sa
projectId=pure-anthos

echo "Creating Service Account"
gcloud iam service-accounts create $newServiceAccount --description="panch service account for POC" --display-name="pn-px-service account" --project=$projectId
accountEmail=$(gcloud iam service-accounts list --project=$projectId --filter=$newServiceAccount --format="value(email)")

echo "downloading the JSON Key"

gcloud iam service-accounts keys create $newServiceAccount-$projectId.json --iam-account $accountEmail


for role in roles/compute.admin roles/iam.serviceAccountUser roles/container.clusterAdmin roles/iam.serviceAccountUser roles/cloudkms.admin roles/cloudkms.cryptoKeyEncrypterDecrypter roles/cloudkms.publicKeyViewer roles/cloudkms.cryptoOperator; do
gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=$role > /dev/null
done

#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/compute.admin > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/iam.serviceAccountUser > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/container.clusterViewer  > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/cloudkms.cryptoKeyEncrypterDecrypter  > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/cloudkms.publicKeyViewer > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/cloudkms.admin > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/cloudkms.cryptoOperator > /dev/null
#gcloud projects add-iam-policy-binding $projectId --member=serviceAccount:$accountEmail --role=roles/container.clusterAdmin > /dev/null

echo "Add Service Account to Kubernetes secret"

gcloud kms keys list --keyring=projects/pure-anthos/locations/us-east1/keyRings/key-ring-pnayak

echo "Copy the key name, create secret"
kubectl -n kube-system create secret generic px-gcloud --from-file=gcloud-secrets/ --from-literal=gcloud-kms-resource-id=projects/pure-anthos/locations/us-east1/keyRings/key-ring-pnayak/cryptoKeys/key-pnayak/cryptoKeyVersions/1


