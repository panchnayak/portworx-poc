#!/usr/bin/env bash

export namespace=postgres-demo

echo "========================================================"
echo "This will destroy everything in namespace $namespace!!!!"
echo " "
read -p "Hit CTRL-C to escape, press ENTER to continue... " -n1

kubectl delete ns $namespace
kubectl delete sc px-repl3-sc-demotemp