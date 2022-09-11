PORTWORX DEMO Steps

1.Deploy Portworx
2.Create StorageClass
3.Create a PVC
4.Deploy Postgress DB
5.Simulate Node Failure
6.Simulate Data disk full
7.5.Simulate Human Error - Database Deletion

### 1.Deploy Portworx


### Setup the portworx Environemnt

### Set the pxctl command and get the cluster status

PX_POD=$(kubectl -n portworx get pods -l name=portworx -o jsonpath='{.items[0].metadata.name}')

export PX_POD

PX_POD=$(kubectl -n portworx get pods -l name=portworx  -o jsonpath='{.items[0].metadata.name}')
alias pxctl='kubectl exec -n portworx $PX_POD -- /opt/pwx/bin/pxctl'
alias p='kubectl exec $PX_POD -n portworx -- /opt/pwx/bin/pxctl'


### USE CASE - DEPLOY POSTGRESS DB on KUBERNETS
### 1.Create namespace postgres-demo
kubectl create ns postgres-demo

### 2.Let's check out the pods running portworx
kubectl -n portworx get pods -l name=portworx -o wide

### 3. Now create a storage class for our application.

Storage classes allow Kubernetes to tell the underlying volume driver how to set up the volumes for capabilites such as IO profiles, HA levels, etc.

cat px-repl3-sc-demotemp.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
    name: px-repl3-sc-demotemp
provisioner: kubernetes.io/portworx-volume
parameters:
   repl: "3"
   io_profile: "db_remote"
   priority_io: "high"
allowVolumeExpansion: true
reclaimPolicy: Delete

kubectl create -f px-repl3-sc-demotemp.yaml

### Now create a volume for the application

cat px-postgres-pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: px-postgres-pvc
spec:
   storageClassName: px-repl3-sc-demotemp
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 1Gi
```
kubectl -n postgres-demo apply -f px-postgres-pvc.yaml
```

### 5.And now we'll take a look at the application in YAML format and deploy it 

```
cat postgres-app.yaml

kubectl -n postgres-demo create -f postgres-app.yaml

kubectl -n postgres-demo get pods -l app=postgres -o wide
```
### Now we'll run a Portworx command to see what the Portworx cluster reveals about the volume

# The syntax for this command is pxctl volume inspect VOL.

```
pxctl volume list pvc-ea54cd20-828f-427e-b550-9fb4c08421e0
```

### We are going to exec into the Postgres pod and run a command to populate data, and then get the count
```
kubectl -n postgres-demo get pods -l app=postgres
```

### Create the database

```
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-v4mdd -- psql << EOF
create database pxdemo;
\l
\q
EOF
```

### Populate the database with test data
```
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-v4mdd -- pgbench -i -s 50 pxdemo;
```


### Get a count of the records

```
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-v4mdd -- psql pxdemo<< EOF
\dt
select count(*) from pgbench_accounts;
\q
EOF
```

### USE CASE - NODE FAILURE

### Now that we have 5,000,000 records in our running database, let's simulate a node failure
We will cordon the Kubernetes node, and kill the application, which will have to start on another node
```
kubectl -n postgres-demo get pods -l app=postgres -o wide
kubectl cordon ip-10-0-137-57.us-east-2.compute.internal
kubectl -n postgres-demo delete pod postgres-c8b6f5bdb-v4mdd
```
### What just happened? 

We created a database, added 5 million records to it, and simulated a node failure Within seconds, it was running again on a second replica of the data on another node

So lets validate the data
```
kubectl -n postgres-demo get pods -l app=postgres

kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-kxjqg -- psql pxdemo<< EOF
\dt
select count(*) from pgbench_accounts;
\q
EOF
```

### USE CASE - APP FAILURE

# Now let's simulate an app failure due to lack of disk space
We'll add more records to the database, exceeding the original 1GiB volume capacity, Next we will run further database record creation until we fill up the volume
```
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-kxjqg -- pgbench -c 10 -j 2 -t 10000 pxdemo
```
### The application crashed, citing lack of space. Let's fix that by patching the volume to a larger size, all from Kubernetes

```
diff px-postgres-pvc.yaml px-postgres-pvc-larger.yaml
kubectl -n postgres-demo apply -f px-postgres-pvc-larger.yaml
watch kubectl -n postgres-demo get pvc px-postgres-pvc
watch kubectl -n postgres-demo get pods
```

#### What just happened? We extended the size of the volume.
Within seconds, the pod was running again with more space for data, Lets validate the data
```
kubectl -n postgres-demo get pods -l app=postgres
```
### Let's get the count from the table

Let's get the count from the database table
```
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-kxjqg -- psql pxdemo<< EOF
\dt
select count(*) from pgbench_accounts;
\q
EOF
```

#### Now let's simulate data loss due to human error, with recovery from a snapshot, Take an adhoc snapshot from kubectl:
cat px-snap.yaml
apiVersion: volumesnapshot.external-storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: px-postgres-snapshot
spec:
  persistentVolumeClaimName: px-postgres-pvc

```
kubectl -n postgres-demo create -f px-snap.yaml
kubectl -n postgres-demo get volumesnapshots.volumesnapshot,volumesnapshotdatas
```

### USE CASE - HUMAN ERROR

### Now we're going to go ahead and do something stupid because we're here to learn.

```
kubectl -n postgres-demo get pods -l app=postgres
kubectl -n postgres-demo exec -i postgres-c8b6f5bdb-kxjqg -- psql << EOF
drop database pxdemo;
\l
\q
EOF
```

### Ok, so we deleted our database, what now? Restore your snapshot and carry on.

In this demo, we will clone the snapshot to a new PVC, and launch a new copy of the app with the restored data

### Here is the code to create the clone

```
cat px-snap-pvc.yaml
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: px-postgres-snap-clone
  annotations:
    snapshot.alpha.kubernetes.io/snapshot: px-postgres-snapshot
spec:
  accessModes:
     - ReadWriteOnce
  storageClassName: stork-snapshot-sc
  resources:
    requests:
      storage: 10Gi
```
kubectl -n postgres-demo create -f px-snap-pvc.yaml
kubectl -n postgres-demo get pvc
```
Here is the postgres app pointing to that newly restored volume
```
cat postgres-app-restore.yaml
```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres-snap
spec:
  selector:
    matchLabels:
      app: postgres-snap
  replicas: 1
  template:
    metadata:
      labels:
        app: postgres-snap
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: px/running
                operator: NotIn
                values:
                - "false"
              - key: px/enabled
                operator: NotIn
                values:
                - "false"
      containers:
      - name: postgres
        image: postgres:9.5
        imagePullPolicy: "IfNotPresent"
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_USER
          value: pgbench
        - name: PGUSER
          value: pgbench
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: postgres-pass
              key: password.txt
        - name: PGBENCH_PASSWORD
          value: superpostgres
        - name: PGDATA
          value: /var/lib/postgresql/data/pgdata
        volumeMounts:
        - mountPath: /var/lib/postgresql/data
          name: postgresdb
      volumes:
      - name: postgresdb
        persistentVolumeClaim:
          claimName: px-postgres-snap-clone
```
kubectl -n postgres-demo create -f postgres-app-restore.yaml
kubectl -n postgres-demo get pods -l app=postgres-snap -o wide
```


watch kubectl -n postgres-demo get pods -l app=postgres-snap -o wide

### Finally, let's validate that we have our data, again! Let's get the count from the database table
```
kubectl -n postgres-demo exec -i postgres-snap-7f55f7b946-5vfzp -- psql pxdemo<< EOF
\dt
select count(*) from pgbench_accounts;
\q
EOF
```

### The demo is complete! We have demonstrated recovery from failed nodes/pods, recovery from running out of capacity, and recovering of data from a snapshot after human error

