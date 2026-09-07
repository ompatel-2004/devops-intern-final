# DevOps Intern Final Assessment

[![CI Pipeline](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/ci.yml)
[![Validate and Deploy Nomad Job](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/nomad-validation.yml/badge.svg)](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/nomad-validation.yml)
[![Observability Validation](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/observability-validation.yml/badge.svg)](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/observability-validation.yml)

- **Name:** Om Patel
- **Date:** September 2026
- **Role:** DevOps Intern
- **Repository:** https://github.com/ompatel-2004/devops-intern-final
- **Release:** [`v1.0.0`](https://github.com/ompatel-2004/devops-intern-final/releases/tag/v1.0.0)
- **Container Registry:** `ghcr.io/ompatel-2004/devops-intern-final:latest`

---

## 1. Architecture Overview

This project implements an end-to-end, reproducible deployment and observability pipeline for an unprivileged Alpine-based NGINX web application.

The application source is version-controlled with conventional commits, tested and packaged via GitHub Actions, published as an immutable container image to GitHub Container Registry (GHCR), orchestrated via HashiCorp Nomad with Consul service checks, and continuously monitored through a Grafana Loki and Promtail log ingestion pipeline.

```text
[ Developer Commit / PR ]
           │
           ▼
┌────────────────────────────────────────────────────────┐
│               GitHub Actions CI/CD Pipeline            │
│  1. Lint: ShellCheck (scripts) & Hadolint (Dockerfile) │
│  2. Build: Inject Commit SHA into static index.html    │
│  3. Test: Verify /healthz returns HTTP 200             │
│  4. Publish: Push tagged image to GHCR (main branch)   │
└──────────────────────────┬─────────────────────────────┘
                           │
                           ▼
              ┌──────────────────────────┐
              │ GitHub Packages (GHCR)   │
              └────────────┬─────────────┘
                           │
         ┌─────────────────┴─────────────────┐
         ▼                                   ▼
┌───────────────────────────────┐ ┌───────────────────────────────────┐
│   HashiCorp Nomad & Consul    │ │   Grafana Loki Log Stack          │
│ • Nomad Job (docker driver)   │ │ • Promtail scrapes stdout/stderr  │
│ • Dynamic HTTP host port      │ │ • Ships structured logs to Loki   │
│ • Consul /healthz checks      │ │ • Visualized via Grafana LogQL    │
│ • Rolling update & auto-revert│ └───────────────────────────────────┘
└───────────────────────────────┘
