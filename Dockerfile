FROM python:3.6-slim

ARG PWD=/opt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git-core \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY Pipfile* ${PWD}/

WORKDIR ${PWD}

RUN pip install -U pip setuptools wheel pipenv \
    && pipenv install --system --deploy \
    && rm -f Pipfile* \
    && rm -rf /root/.cache/pip

CMD ["memote", "-h"]
