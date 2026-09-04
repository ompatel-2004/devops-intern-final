# Log Aggregation Setup (Loki & Promtail)

## 1. Overview
This directory contains the observability stack configuration for aggregating application access and error logs using Grafana Loki, Promtail, and Grafana.

## 2. Stack Startup
To launch the logging stack locally:

    cd monitoring
    docker compose up -d

Verify services:

    docker compose ps

* Loki Endpoint: http://localhost:3100
* Promtail Metrics/Status: http://localhost:9080
* Grafana UI: http://localhost:3000 (Credentials: admin / admin)

## 3. Label Architecture
Promtail applies structured labels to incoming log streams:
* job: nginx-app
* container: nginx-server
* service: nginx-app

## 4. LogQL Verification Queries

### Fetch All NGINX Application Logs
    {job="nginx-app"}

### Isolate HTTP Error Status Codes (Non-200)
    {job="nginx-app"} |~ "( 4[0-9]{2} | 5[0-9]{2} )"

## 5. Troubleshooting & Resolutions
1. Loki Volume Permissions: Configured using ephemeral filesystem storage rules to prevent write permission issues on non-root runtime environments.
2. Promtail Host Log Mount: Read-only container mounts configured for /var/log and container paths to allow unprivileged log ingestion.
