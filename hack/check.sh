#!/usr/bin/env bash

kubectl cluster-info
printf "\n"

kubectl get namespaces
printf "\n"

items=$(kubectl get pods -n kube-system -o json | jq -r '.items | length')

printf "\n number of pods in kube-system is '%s' " "$items"

if [[ items -ge 7 ]] ;
then
 exit 0
else
 exit 1
fi