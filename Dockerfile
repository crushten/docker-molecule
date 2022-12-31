# syntax=docker/dockerfile:1
FROM python:3.10-bullseye AS build

# hadolint ignore=DL3008
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends build-essential gcc && rm -rf /var/lib/apt/lists/*

# fixes CVE-2022-40897
# hadolint ignore=DL3013
RUN pip install --no-cache-dir setuptools>=65.5.1 && python3 -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

# hadolint ignore=DL3045
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.10-slim-bullseye

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# fixes CVE-2022-40897
# hadolint ignore=DL3013
RUN pip install --no-cache-dir setuptools>=65.5.1

COPY --from=build /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"