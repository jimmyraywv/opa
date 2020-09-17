#!/usr/bin/env bash
#set -o errexit

kubectl delete ns opa 2>&1
kubectl delete ns opa-test 2>&1
kubectl delete ns opa-test1 2>&1
kubectl delete clusterrole opa 2>&1
kubectl delete clusterrolebinding opa 2>&1
kubectl delete ValidatingWebhookConfiguration -l app=opa 2>&1

