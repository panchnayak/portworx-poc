
## Wotking with PDS API

Before working with API ensure that you have a namespace labeled for creating your PDS services,otherwise the namespace will not appear on PDS console for creation of Data Services.

### Label the namespaces to be visible to PDS

```
kubectl label namespaces $NAMESPACE pds.portworx.com/available=true --overwrite=true
```
For authentication purpose, before one can work with PDS API, he/she has to create the API bearoer token which can be passed on to your API calls as follows.

To see the details of the API open the following URL on a Browser.

https://prod.pds.portworx.com/swagger/index.html

### Create an API Token

Login to the PDS console and Create a Bearer Token

https://user-images.githubusercontent.com/31803506/205083111-9exxxf5-xxxx-47ba-a489-f35xxxxbf9b8.mp4

### Get Available Data Services

curl https://staging.pds.portworx.com/api/data-services -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq '.data[].name'

```
Example:

curl https://staging.pds.portworx.com/api/data-services -H "Authorization: Bearer eyJhbGcixxxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDQyNzU1NCwiaWF0IjoxNjY5ODIyNzY4LCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiZjU3NDA3ZDEtMWNlZC00NWI3LTk5NmYtOTMzNDU0NmYxOGY2In0.0C-4w1zI13eE0ak0gyNaPm1LStdxpC4FxwwQi3PgwOKB6mbDwj6Pve3OcQ5EIFxnDlPTpE081sxkzqcD8iuXvA" | jq '.data[].name'
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

curl https://staging.pds.portworx.com/api/tenants/fb942f2c-d185-4c8a-xxxx-bb7f34xxxxa0/deployment-targets -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDQyNzU1NCwiaWF0IjoxNjY5ODIyNzY4LCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiZjU3NDA3ZDEtMWNlZC00NWI3LTk5NmYtOTMzNDU0NmYxOGY2In0.0C-4w1zI13eE0ak0gyNaPm1LStdxpC4FxwwQi3PgwOKB6mbDwj6Pve3OcQ5EIFxnDlPTpE081sxkzqcD8iuXvA" | jq
```

### Get Existing Deployments

```
curl https://staging.pds.portworx.com/api/projects/project-id/deployments -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq '.data[].cluster_resource_name'

Example : 

curl https://staging.pds.portworx.com/api/projects/fd53fa1a-xxx-4d39-98ae-e2cf12xxxx2/deployments -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq '.data[].cluster_resource_name'
```
### Get the Tenant ID
```
curl https://staging.pds.portworx.com/api/tenants/fb942f2c-d185-4c8a-97a5-bb7f348aa2a0/deployment-targets -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq

...........
{
      "id": "fcc6885a-xxxx-4846-9601-256axxxf1",
      "created_at": "2022-10-18T19:00:21.089571Z",
      "updated_at": "2022-12-01T16:02:48.870862Z",
      "name": "panch-fsa-rancher",
      "status": "healthy",
      "last_health_check": "2022-12-01T16:02:48.869814Z",
      "last_operator_heartbeat": null,
      "metadata": {
        "pds_chart_version": "1.8.1",
        "kube_api_version": "v1.22.13+rke2r1",
        "kube_platform": "generic",
        "px_service_namespace": "portworx",
        "px_csi_enabled": "unknown",
        "px_version": "",
        "px_status": "STATUS_NONE",
        "pds_operator_version": "",
        "pds_features": ""
      },
      "tenant_id": "fb942f2c-d185-xxxx-97a5-bb7f3xxxx2a0",
      "cluster_id": "fc3f2ac7-3a5d-xxxx-8afa-8e2cb9xxxxa3f",
      "account_id": "b0b7de54-0d86-xxxx-a655-d52c6xxxxxae63"
............
```

Note the deployment target

### Get Namespace ID in the Target Cluster

curl https://staging.pds.portworx.com/api/deployment-targets/fcc6885a-b585-xxxx-9601-25xxxx2bb2f1/namespaces -H "Authorization: Bearer bearer_token" -H "Accept: application/json" | jq

```
Example : 

curl https://staging.pds.portworx.com/api/deployment-targets/fcc6xxx5a-b585-xxxx-9601-256axxxxb2f1/namespaces -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   364  100   364    0     0    705      0 --:--:-- --:--:-- --:--:--   704
{
  "data": [
    {
      "id": "213d3b11-aee5-41cc-bd1e-6xxxxx72a1",
      "created_at": "2022-10-18T19:02:31.487175Z",
      "updated_at": "2022-10-18T19:02:31.487175Z",
      "name": "pds-demo",
      "status": "available",
      "deployment_target_id": "fcc6xxxxa-b585-4846-9601-256xxxx2f1",
      "tenant_id": "fb942f2c-xxxx-4c8a-97a5-bbxxxxxxaa2a0",
      "account_id": "b0b7de54-xxxx-xxxx-a655-d52xxxx3e63"
    }
  ],
  "pagination": null
}

```
![Get NameSpace](./images/get-namespace.jpeg)

### Get the Application Configuration template ID

curl https://staging.pds.portworx.com/api/tenants/fb9xxxxc-d185-4c8a-97a5-bb7f348xxxa0/application-configuration-templates -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq

### Create a new MongoDB Deployment

1.MongoDB Data Services ID is - 652c8012-31cb-4716-968c-981c56f46afe

```
curl https://staging.pds.portworx.com/api/tenants/fbxxx2c-d185-4c8a-97a5-bb7f3xxxxa0/application-configuration-templates -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq
```

2.The application-configuration-templates ID corresponds to Data servicers ID is - d647362d-3d33-46d2-9b3a-85fab2d8d114

```
curl https://staging.pds.portworx.com/api/tenants/fxxxxc-d185-4c8a-97a5-bb7fxxxxa0/resource-settings-templates -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq
```

3.We need the resource_settings_template_id curresponds to the Data Service ID : 09c77e89-9169-4240-a89a-e04987c6af0e


4. We need the storage_options_template_id

```
curl https://staging.pds.portworx.com/api/tenants/fb9xxxx-d185-4c8a-97a5-bb7f348aa2a0/storage-options-templates -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" -H "Accept: application/json" | jq
```

For best effort spread is - 29956f6d-5e70-4a18-a5cc-20dxxxxd1c

with all the above values edit the deploy.json file and the run the curl command. This is going to be a "POST" API request

```
curl \
    -X POST \
    -H "Content-Type: application/json" \
    -d @./deploy.json \
    -H "Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5pbCIsImV4cCI6MTY3MDUwOTc5OSwiaWF0IjoxNjY5OTA1MDAwLCJpc3MiOiJwZHMtdXNlckFQSUtleSIsIm5hbWUiOiIyOGFkMDAxMi1iZmY2LTQzNjUtODk4Ny1lN2U4MWU1NDUwYTkiLCJyb2xlcyI6bnVsbCwic3ViIjoiNmY0ZThjYmUtYWJmYi00OGY2LTg1ODAtZmIzMzBlZTk4MGNlIn0.V-ZY3sJ8smA064j71tt9Npl9MR7jKOI9M-5OkFVZI9dyHoMR6FXK4btB-f9qrMRHOk8833clEDO9eNI1boEjPg" \
    https://staging.pds.portworx.com/api/projects/fd5xxxx-eb68-4d39-98ae-e2cf1xxxxed2/deployments | jq
```

This will create the required Data services.

![Create MongoDB Service](./images/create-db-service.jpg)












