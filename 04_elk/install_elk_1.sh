#!/bin/bash
kubectl apply -f yamls/elastic-search-cm.yaml
kubectl apply -f yamls/elastic-search-pv.yaml
kubectl apply -f yamls/elastic-search-sts.yaml
kubectl apply -f yamls/elastic-search-svc.yaml
