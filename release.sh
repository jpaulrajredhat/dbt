#!/usr/bin/env bash

# Safeties on: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail
docker login quay.io -u 'jpaulraj_se_jboss' -p 'Redhat2024$'

DEFAULT_TAG=quay.io/osclimate/osclimate-pcaf-dbt:1.0
TAG=${TAG:-$DEFAULT_TAG}

docker buildx ls | grep multiarch || docker buildx create --name multiarch --use

docker buildx build --push \
    --platform linux/arm64,linux/amd64 \
    --tag "$TAG" \
    .