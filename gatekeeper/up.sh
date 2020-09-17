#!/usr/bin/env bash
#set -o errexit

#kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

kubectl apply -f config/gatekeeper.yaml
