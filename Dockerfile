FROM python:3.5-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git-core \
    && rm -rf /var/lib/apt/lists/*

COPY Pipfile* /opt/

WORKDIR /opt

RUN pip install -U pipenv \
    && pipenv install --system --deploy \
    && rm -f /opt/Pipfile* \
    && rm -rf /root/.cache/pip

ENTRYPOINT ["memote"]
CMD ["-h"]
