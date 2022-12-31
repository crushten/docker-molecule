# syntax=docker/dockerfile:1
FROM python:3.10-slim-bullseye

# hadolint ignore=DL3008
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends build-essential gcc && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3045
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
