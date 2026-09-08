# Loki and Grafana Setup

This directory contains the configuration used for the logging part of the
DevOps assessment.

The stack consists of:

- Loki — log storage
- Promtail — log collection
- Grafana — log exploration

## Start the stack

From the repository root:

```bash
cd monitoring
docker compose up -d
