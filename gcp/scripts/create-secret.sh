PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
alias pxctl='kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl'

pxctl status

pxctl secrets gcloud create-secret --secret_id $1 --passphrase $2

pxctl secrets gcloud list-secrets
