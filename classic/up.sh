#!/usr/bin/env bash
#set -o errexit

OWNER="jimmy"
CA_BUNDLE=""

cat templates/opa-rbac-template.yaml | sed -e "s/__OWNER_VALUE__/${OWNER}/g" > "generated/config/opa-rbac.yaml"
kubectl apply -f generated/config/opa-rbac.yaml

kubectl label --overwrite namespace default opa-webhook=ignore
kubectl label --overwrite namespace kube-system opa-webhook=ignore
kubectl label --overwrite namespace opa opa-webhook=ignore

openssl genrsa -out generated/secrets/opa-ca.key 2048 2>&1
openssl req -x509 -new -nodes -key secrets/opa-ca.key -days 100000 -out generated/secrets/opa-ca.crt -subj /CN=admission_ca 2>&1
openssl genrsa -out generated/secrets/opa-server.key 2048 2>&1
openssl req -new -key generated/secrets/opa-server.key -out generated/secrets/opa-server.csr -subj /CN=opa.opa.svc -config templates/opa-server.conf 2>&1
openssl x509 -req -in generated/secrets/opa-server.csr -CA generated/secrets/opa-ca.crt -CAkey generated/secrets/opa-ca.key -CAcreateserial -out generated/secrets/opa-server.crt -days 100000 -extensions v3_req -extfile templates/opa-server.conf 2>&1

kubectl -n opa delete secret opa-server 2>&1
kubectl -n opa create secret tls opa-server --cert=generated/secrets/opa-server.crt --key=generated/secrets/opa-server.key

cat templates/admission-controller-template.yaml | sed -e "s/__OWNER_VALUE__/${OWNER}/g" > "generated/config/opa-admission-controller.yaml"
kubectl apply -f config/opa-admission-controller.yaml
  
CA_BUNDLE="$(base64 secrets/opa-ca.crt)"

cat templates/webhook-configuration-template.yaml | sed -e "s#__OWNER_VALUE__#${OWNER}#g;s#__CA_BUNDLE_VALUE__#${CA_BUNDLE}#g" > "generated/config/opa-webhook-configuration.yaml"
kubectl apply -f generated/config/opa-webhook-configuration.yaml
