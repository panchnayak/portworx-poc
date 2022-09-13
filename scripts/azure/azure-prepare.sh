#!/bin/bash -x

az role definition create --role-definition '{
    "Name": "pn-px-cloud-drive",
    "Description": "",
    "AssignableScopes": [ "/subscriptions/536a0a78-c106-4cf1-b62f-f02d84260245" ],
    "Permissions": [
        {
            "Actions": [
                "Microsoft.ContainerService/managedClusters/agentPools/read",
                "Microsoft.Compute/disks/delete",
                "Microsoft.Compute/disks/write",
                "Microsoft.Compute/disks/read",
                "Microsoft.Compute/virtualMachines/write",
                "Microsoft.Compute/virtualMachines/read",
                "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/write",
                "Microsoft.Compute/virtualMachineScaleSets/virtualMachines/read"
            ],
            "NotActions": [],
            "DataActions": [],
            "NotDataActions": []
        }
    ]
}'