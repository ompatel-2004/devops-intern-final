# Log Aggregation Setup — Loki, Promtail & Grafana

## 1. Overview

The monitoring stack collects NGINX container logs using:

- Grafana Loki — log aggregation and storage
- Promtail — log collection and forwarding
- Grafana — log exploration and visualization

The NGINX container writes access and error logs to stdout/stderr. Docker stores these container logs as JSON log files. Promtail discovers the Docker containers through the Docker API and collects logs only from the `nginx-app` container.

## 2. Architecture

```text
NGINX Container
      |
      | stdout / stderr
      v
Docker JSON Logs
      |
      v
Promtail
      |
      | HTTP push
      v
Loki
      |
      v
Grafana Explore