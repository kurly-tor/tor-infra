#!/bin/bash
kubectl apply -f yamls/kibana-cm.yaml
kubectl apply -f yamls/kibana-svc.yaml
kubectl apply -f yamls/kibana-deploy.yaml
