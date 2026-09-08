# DevOps Intern Final Assessment

![CI Pipeline](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/ci.yml/badge.svg)
![Nomad Validation](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/nomad-validation.yml/badge.svg)
![Observability Validation](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/observability-validation.yml/badge.svg)

## Submission Details

- **Name:** Om Patel
- **Role:** DevOps Intern
- **Assessment:** DevOps Intern Final Assessment
- **Submission Date:** 09 September 2026
- **Repository:** https://github.com/ompatel-2004/devops-intern-final
- **Release:** `v1.0.0`
- **Container Registry:** `ghcr.io/ompatel-2004/devops-intern-final`

---

# 1. Project Overview

This project implements an end-to-end DevOps pipeline for a small NGINX web application.

The implementation covers:

- Git-based source control
- Feature-branch development and pull requests
- Shell scripting and validation
- Docker containerisation
- NGINX on port `8080`
- Non-root container execution
- GitHub Actions CI/CD
- ShellCheck and Hadolint validation
- Docker image build and testing
- GitHub Container Registry (GHCR)
- HashiCorp Nomad deployment
- Consul service registration and health checks
- Dynamic Nomad port mapping
- Loki log aggregation
- Promtail log collection
- Grafana log exploration
- Reproducible documentation
- Troubleshooting and validation evidence

The application exposes port `8080` and provides a `/healthz` endpoint that returns HTTP `200`.

---

# 2. Architecture

```text
                           Developer
                               |
                               v
                     Git / Feature Branch
                               |
                               v
                         GitHub Pull Request
                               |
                               v
                    +-----------------------+
                    |    GitHub Actions     |
                    |-----------------------|
                    | ShellCheck             |
                    | Hadolint               |
                    | Docker Build           |
                    | Application Tests      |
                    | Health Check           |
                    +-----------+-----------+
                                |
                                v
                    +-----------------------+
                    |         GHCR           |
                    |-----------------------|
                    | SHA image tag          |
                    | latest image tag       |
                    +-----------+-----------+
                                |
                                v
                    +-----------------------+
                    |     Nomad + Consul    |
                    |-----------------------|
                    | Docker driver          |
                    | Dynamic HTTP port      |
                    | /healthz check         |
                    | Rolling update         |
                    | Auto-revert            |
                    +-----------+-----------+
                                |
                                v
                         NGINX Application
                                |
                                | container logs
                                v
                            Promtail
                                |
                                v
                              Loki
                                |
                                v
                            Grafana
                                |
                                v
                              LogQL

---

# 3. Repository Structure

devops-intern-final/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── nomad-validation.yml
│       └── observability-validation.yml
│
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
│
├── docs/
│   └── screenshots/
│
├── monitoring/
│   ├── docker-compose.yaml
│   ├── loki-config.yaml
│   ├── promtail-config.yaml
│   ├── loki_setup.md
│   └── grafana/
│       └── provisioning/
│
├── nomad/
│   └── nginx-app.nomad.hcl
│
├── scripts/
│   ├── healthcheck.sh
│   └── sysinfo.sh
│
├── .gitignore
└── README.md
