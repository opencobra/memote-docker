#!/usr/bin/env bash

set -ev

repo="opencobra/memote"
label="$repo:$1"

docker build -t "$label" .
docker push "$label"

if [[ "$(git symbolic-ref --short HEAD)" = "master" ]]; then
   docker tag "$label" "$repo:latest"
   docker push "$repo:latest"
fi
