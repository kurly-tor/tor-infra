#!/bin/bash

# remove master taint for deploy in master node
# kubectl taint nodes master node-role.kubernetes.io/master-node/master-

# create & set default tor ns
kubectl apply -f yamls/tor_ns.yaml
kubectl config set-context --current --namespace=tor
kubectl apply -f yamls/tor_sa.yaml
echo "All Done"
