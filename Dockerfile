FROM python:3.6-slim

ENV PYTHONUNBUFFERED=1

ARG USER_=memote
ARG UID=1000
ARG GID=1000

ENV HOME="/home/${USER_}"

RUN groupadd --system --gid "${GID}" "${USER_}" \
    && useradd --system --create-home --home-dir "${HOME}" \
        --uid "${UID}" --gid "${USER_}" "${USER_}"

RUN chown -R "${USER_}:${USER_}" "${HOME}"

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        git-core \
        openssl \
        openssh-client \
        procps \
    && pip install --upgrade pip setuptools wheel \
    && rm -rf /root/.cache/pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

COPY requirements.* /opt/

RUN set -eux \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

WORKDIR "${HOME}"

# Allow any user ID to run memote in the working directory.
RUN set -eux \
    && chmod o+rx /usr/bin/* /usr/local/bin/* \
    && chmod -R a+rwx "${HOME}"

USER "${USER_}"

CMD ["memote", "-h"]
