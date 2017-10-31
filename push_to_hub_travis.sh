#!/usr/bin/env bash

set -euv

repo="opencobra/memote"
label="$repo:${TRAVIS_TAG}"

docker build -t "$label" .
docker push "$label"

docker tag "$label" "$repo:latest"
docker push "$repo:latest"
