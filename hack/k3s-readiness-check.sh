#!/usr/bin/env bash

kubectl cluster-info
printf "\n"

kubectl get namespaces
printf "\n"

kubectl get pods -n kube-system
printf "\n"

metrics_server=$(kubectl get pods -n kube-system -l k8s-app=metrics-server --field-selector=status.phase==Running -ojson | jq '.items | length'
)

coredns_server=$(kubectl get pods -n kube-system -l k8s-app=kube-dns --field-selector=status.phase==Running -ojson | jq '.items | length'
)

local_path_provisioner=$(kubectl get pods -n kube-system -l app=local-path-provisioner --field-selector=status.phase==Running -ojson | jq '.items | length'
)

items=$((metrics_server + coredns_server + local_path_provisioner))

printf "\nNumber of pods in kube-system that is ready '%s' \n" "$items"

if [[ "$items" -ge 3 ]] ;
then
 exit 0
else
 exit 1
fi