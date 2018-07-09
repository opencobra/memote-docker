# -*- coding: utf-8 -*-

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

"""Parse the latest memote package version from PyPI."""

from packaging.version import parse

import requests


def parse_latest(name):
    """Return the latest package release from PyPI."""
    response = requests.get(f"https://pypi.org/pypi/{name}/json")
    response.raise_for_status()
    releases = [parse(v) for v in response.json()["releases"]]
    return max(v for v in releases if not v.is_prerelease)


if __name__ == "__main__":
    print(parse_latest("memote"))
