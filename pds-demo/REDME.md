### Label the namespaces to be visible to PDS

kubectl label namespaces $NAMESPACE pds.portworx.com/available=true --overwrite=true