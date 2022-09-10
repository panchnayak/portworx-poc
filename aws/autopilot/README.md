### Prerequisites
## Prometheus

Autopilot requires a running Prometheus instance in your cluster. 
If you don’t have Prometheus configured in your cluster, refer to the Prometheus and Grafana to set it up.


### Ceate the autopilot rules

kubectl apply -f autopilotrule-example.yaml

### Create a namespace and Label them

kubectl apply -f namespaces.yaml

### or create with kubectl
export NAMESPACE=<namespace-name>

kubectl create ns

### Apply Labels to the namespaces

kubectl label namespaces $NAMESPACE type: db --overwrite=true

### create the storage class

kubectl apply -f postgres-sc.yaml

### create the volumes in different namespaces

kubectl apply -f postgres-vol.yaml -n pg1
kubectl apply -f postgres-vol.yaml -n pg2


### Deploy the apps

kubectl apply -f postgres-app.yaml -n pg1
kubectl apply -f postgres-app.yaml -n pg2


### Monitor

kubectl get events --field-selector involvedObject.kind=AutopilotRule,involvedObject.name=volume-resize --all-namespaces --sort-by .lastTimestamp