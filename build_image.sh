#!/usr/bin/env bash

# Copyright 2018 Novo Nordisk Foundation Center for Biosustainability,
# Technical University of Denmark.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eux -o pipefail

# Adapted from https://stackoverflow.com/a/39731444.
function docker_tag_exists() {
    curl --silent -f -lSL "https://index.docker.io/v1/repositories/${1}/tags/${2}" &> /dev/null
}


latest=$(python latest_pypi_release.py)
if docker_tag_exists "${IMAGE_REPO}" "${latest}"; then
    echo "Image ${IMAGE_REPO}:${latest} already exists. Nothing to do."
else
    docker build --build-arg RELEASE="${latest}" -t "${IMAGE_REPO}:${latest}" -t "${IMAGE_REPO}:latest" .
    docker push "${IMAGE_REPO}:${latest}"
    docker push "${IMAGE_REPO}:latest"
fi
