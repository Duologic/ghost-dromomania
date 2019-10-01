#!/bin/bash

NAMESPACE=$(kubectl config current-context)

BRANCH="master"

helm repo add fluxcd https://charts.fluxcd.io
helm upgrade flux fluxcd/flux \
  --install \
  --set rbac.create=true \
  --set helmOperator.create=true \
  --set git.url=git@github.com:duologic/ghost-dromomania.git \
  --set git.branch="$BRANCH" \
  --set "git.path=kubernetes/releases/$NAMESPACE" \
  --set git.pollInterval=1m \
  --set git.label="flux-sync-$NAMESPACE" \
  --namespace flux
