kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  annotations:
    volume.beta.kubernetes.io/storage-class: px-repl3-sc
  name: petclinic-db-mysql
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi