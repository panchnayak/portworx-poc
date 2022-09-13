#!/bin/bash -x

#gcloud kms keyrings create px-keyring-pnayak --location us-east1
gcloud kms keys create key-pnayak --keyring key-ring-pnayak --location us-east1  \
   --purpose "asymmetric-encryption"  --default-algorithm "rsa-decrypt-oaep-2048-sha256"