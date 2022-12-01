### Label the namespaces to be visible to PDS

Before a Target Cluster namespace can appear on PDS console for creation of Data Services you have to label it as follows

```
kubectl label namespaces $NAMESPACE pds.portworx.com/available=true --overwrite=true
```

## Wotking with PDS API

For authentication purpose, before one can work with PDS API, he/she has to create the API bearoer token which can be passed on to your API calls as follows.

To see the details of the API open the following URL on a Browser.

https://prod.pds.portworx.com/swagger/index.html

### Create an API Token

Login to the PDS console and Create a Bearer Token

https://user-images.githubusercontent.com/31803506/205083111-9ee11df5-0351-47ba-a489-f3554d6bf9b8.mp4

### Get Available Data Services

curl https://staging.pds.portworx.com/api/data-services -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq '.data[].name'

```
Example:

curl https://staging.pds.portworx.com/api/data-services -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDQyNzU1NCwiaWF0IjoxNjY5ODIyNzY4LCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiZjU3NDA3ZDEtMWNlZC00NWI3LTk5NmYtOTMzNDU0NmYxOGY2In0.0C-4w1zI13eE0ak0gyNaPm1LStdxpC4FxwwQi3PgwOKB6mbDwj6Pve3OcQ5EIFxnDlPTpE081sxkzqcD8iuXvA" | jq '.data[].name'
```

![PDS Data Services](./images/pds-data-services.jpg)


### Get all the Accounts

curl https://staging.pds.portworx.com/api/accounts -H "Authorization: Bearer bearer_token" -H "Accept: application/json"  | jq

### Get a Particular Account Details

curl https://staging.pds.portworx.com/api/accounts/account-id -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | json_pp

### Get Tenants Details

curl https://staging.pds.portworx.com/api/accounts/account-id/tenants -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

### Get Tenatnt's Projects

curl https://staging.pds.portworx.com/api/tenants/tenant-id/projects -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

## Databases Deployments

### Get Deployment Targets

curl https://staging.pds.portworx.com/api/tenants/tentant-id/deployment-targets -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

```
Example:

curl https://staging.pds.portworx.com/api/tenants/fb942f2c-d185-4c8a-97a5-bb7f348aa2a0/deployment-targets -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDQyNzU1NCwiaWF0IjoxNjY5ODIyNzY4LCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiZjU3NDA3ZDEtMWNlZC00NWI3LTk5NmYtOTMzNDU0NmYxOGY2In0.0C-4w1zI13eE0ak0gyNaPm1LStdxpC4FxwwQi3PgwOKB6mbDwj6Pve3OcQ5EIFxnDlPTpE081sxkzqcD8iuXvA" | jq
```
### Get Namespace in the Target Cluster

curl https://staging.pds.portworx.com/api/deployment-targets/fcc6885a-b585-4846-9601-256a6b2bb2f1/namespaces -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

```
Example : 

curl https://staging.pds.portworx.com/api/deployment-targets/fcc6885a-b585-4846-9601-256a6b2bb2f1/namespaces -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" | jq
```

![Get NameSpace](./images/get-namespace.jpeg)

### Get Existing Deployments

curl https://staging.pds.portworx.com/api/projects/project-id/deployments -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

### Create a new Deployment

This is going to be a "POST" API request

curl https://staging.pds.portworx.com/api/projects/project-id/deployments -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq













