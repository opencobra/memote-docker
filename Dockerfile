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

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        git-core \
        openssl \
        openssh-client \
    && pip install --upgrade pip setuptools wheel \
    && pip install "memote==${RELEASE}" \
    && rm -rf /root/.cache/pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR "${HOME}"

USER "${TEST_USER}"

CMD ["memote", "-h"]
