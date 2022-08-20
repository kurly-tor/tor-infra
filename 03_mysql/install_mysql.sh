#!/bin/bash
kubectl apply -f yamls/mysql-pv.yaml
kubectl apply -f yamls/mysql-pvc.yaml
kubectl apply -f yamls/mysql-secret.yaml
kubectl apply -f yamls/mysql-svc.yaml
kubectl apply -f yamls/mysql-deploy.yaml
