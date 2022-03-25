#!/usr/bin/env bash

items=$(kubectl get pods -n kube-system -o json | jq -r '.items | length')

echo "number of pods in kube-system is '$items'"

if [[ items -ge 7 ]] ;
then
 exit 0
else
 exit 1
fi