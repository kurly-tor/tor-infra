#!/bin/bash
# install metrics-server for hpa
kubectl apply -f yamls/metrics-server-components.yaml

echo "All Done"
