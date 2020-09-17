#!/usr/bin/env bash
#set -o errexit

#kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

kubectl delete -f config/gatekeeper.yaml
