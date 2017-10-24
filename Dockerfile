FROM python:3.5-slim

COPY Pipfile* /opt/

WORKDIR /opt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git-core \
    && rm -rf /var/lib/apt/lists/* \
    && pip install -U --no-cache-dir pipenv \
    && pipenv install --system --deploy \
    && rm -rf /opt/Pipfile* \
    && rm -rf "${HOME}/.cache/pip"

ENTRYPOINT ["memote"]
CMD ["-h"]
