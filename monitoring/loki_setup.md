# Loki, Promtail and Grafana Setup

This directory contains the centralized logging configuration used by the
DevOps Intern Final Assessment.

The observability stack consists of:

- **Promtail** — discovers Docker containers and ships their logs.
- **Loki** — stores and indexes the log streams.
- **Grafana** — provides the LogQL-based visualization interface.

The NGINX application writes access logs to stdout/stderr. Promtail discovers
the `nginx-app` Docker container and forwards those logs to Loki.

---

## 1. Architecture

```text
NGINX container
      |
      | stdout / stderr
      v
  Promtail
      |
      | Loki Push API
      v
    Loki
      |
      | LogQL
      v
   Grafana
