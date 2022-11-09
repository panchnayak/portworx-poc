kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
    name: px-repl3-sc
provisioner: kubernetes.io/portworx-volume
parameters:
  #openstorage.io/auth-secret-name: px-user-token
  #openstorage.io/auth-secret-namespace: portworx
  repl: "3"
  io_profile: "db"