FROM python:3.6-slim

ENV PYTHONUNBUFFERED=1
ENV TEST_USER=memote
ENV HOME="/home/${TEST_USER}"

ARG UID=1000
ARG GID=1000
ARG RELEASE

RUN groupadd --system --gid "${GID}" "${TEST_USER}" \
    && useradd --system --create-home --home-dir "${HOME}" \
        --uid "${UID}" --gid "${TEST_USER}" "${TEST_USER}"

RUN chown -R "${TEST_USER}:${TEST_USER}" "${HOME}"

WORKDIR "${HOME}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git-core openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -eux \
    && pip install --upgrade pip setuptools wheel \
    && pip install "memote==${RELEASE}" \
    && rm -rf /root/.cache/pip

USER "${TEST_USER}"

CMD ["memote", "-h"]
