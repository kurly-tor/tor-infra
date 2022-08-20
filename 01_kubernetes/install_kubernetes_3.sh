#!/bin/bash

export secret_name={your secret}
export decoded_token=$(kubectl get secret $secret_name -o jsonpath='{.data.token}'| base64 -d)

# create user by sa
kubectl config set-credentials github-action-user \
	--token=$decoded_token

# create context by sa & user
kubectl config set-context github-action-context \
	--cluster=kubernetes --user=github-action-user

