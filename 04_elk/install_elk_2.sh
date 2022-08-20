#!/bin/bash
cp mysql-connector-java-8.0.18.jar /tmp/
kubectl apply -f yamls/logstash-svc.yaml
kubectl apply -f yamls/logstash-cm.yaml
kubectl apply -f yamls/logstash-deploy.yaml
