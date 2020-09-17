#!/usr/bin/env bash
#set -o errexit

NEWLINE=$'\n'
PREFIX="" && [[ "$PWD" != *tests* ]] && PREFIX="tests/"
clear

kubectl apply -f ${PREFIX}0-ns.yaml

echo "${NEWLINE}"

echo ">>> 1. Good config..."
kubectl apply -f ${PREFIX}1-ok.yaml
sleep 2
kubectl delete -f ${PREFIX}1-ok.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 2. Missing deployment metadata labels..."
kubectl apply -f ${PREFIX}2-dep-lab.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 3. Missing deployment spec template metadata labels..."
kubectl apply -f ${PREFIX}3-dep-spec-temp-meta-lab.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 4. Missing deployment spec template container security context..."
kubectl apply -f ${PREFIX}4-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 5. Missing deployment spec template container security context elements..."
kubectl apply -f ${PREFIX}5-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 6. Deployment spec template container security context allowPrivilegeEscalation ..."
kubectl apply -f ${PREFIX}6-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 7. Missing deployment spec template container security context runAsUser & readOnlyRootFilesystem..."
kubectl apply -f ${PREFIX}7-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 8. Deployment spec template container security context runAsUser = 0"
kubectl apply -f ${PREFIX}8-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 9. Missing deployment spec template container security context readOnlyRootFilesystem"
kubectl apply -f ${PREFIX}9-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 10. Deployment spec template container security context readOnlyRootFilesystem = false"
kubectl apply -f ${PREFIX}10-dep-sec-cont.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 11. Disallowed container registry..."
kubectl apply -f ${PREFIX}11-dep-reg-allow.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 12. Wrong AWS role annotated on pod..."
kubectl apply -f ${PREFIX}12-dep-wrong-role.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 13. No AWS role annotation defined..."
kubectl apply -f ${PREFIX}13-dep-no-role.yaml
sleep 2
kubectl delete -f ${PREFIX}13-dep-no-role.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 14. Missing deployment spec template container resources..."
kubectl apply -f ${PREFIX}14-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 15. Missing deployment spec template container resources.limits..."
kubectl apply -f ${PREFIX}15-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 16. Missing deployment spec template container resources.limits.cpu..."
kubectl apply -f ${PREFIX}16-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 17. Missing deployment spec template container resources.limits.memory..."
kubectl apply -f ${PREFIX}17-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 18. Missing deployment spec template container resources.requests..."
kubectl apply -f ${PREFIX}18-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 19. Missing deployment spec template container resources.requests.cpu..."
kubectl apply -f ${PREFIX}19-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 20. Missing deployment spec template container resources.requests.memory..."
kubectl apply -f ${PREFIX}20-dep-res.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 30. Using deployment image latest version..."
kubectl apply -f ${PREFIX}30-dep-latest.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 31. Missing deployment image version..."
kubectl apply -f ${PREFIX}31-dep-no-ver.yaml
sleep 2

echo "${NEWLINE}"

echo ">>> 100. All failures..."
kubectl apply -f ${PREFIX}100-dep-all-fail.yaml
sleep 2

echo "${NEWLINE}"

kubectl delete -f ${PREFIX}0-ns.yaml
















