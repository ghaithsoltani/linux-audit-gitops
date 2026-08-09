# Linux Audit GitOps Pipeline

[![CI](https://github.com/ghaithsoltani/linux-audit-gitops/actions/workflows/ci.yml/badge.svg)](https://github.com/ghaithsoltani/linux-audit-gitops/actions/workflows/ci.yml)
[![CD](https://github.com/ghaithsoltani/linux-audit-gitops/actions/workflows/cd.yml/badge.svg)](https://github.com/ghaithsoltani/linux-audit-gitops/actions/workflows/cd.yml)

A production-grade GitOps pipeline where infrastructure is managed entirely through Git.

## Architecture
## What This Does

- **Git Hooks** — enforce quality before code leaves your machine
- **CI Pipeline** — ShellCheck, secret scanning, Docker build test on every PR
- **CD Pipeline** — automatic deployment to server on merge to main
- **Health Checks** — post-deployment verification with automatic rollback
- **Monitoring** — Prometheus metrics and Loki log aggregation

## Stack

| Component | Technology |
|-----------|-----------|
| Application | Nginx |
| Containerization | Docker + Docker Compose |
| CI/CD | GitHub Actions |
| Secret Scanning | Gitleaks |
| Monitoring | Prometheus + Grafana |
| Log Aggregation | Loki |

## Quick Start

```bash
# Clone repository
git clone git@github.com:ghaithsoltani/linux-audit-gitops.git
cd linux-audit-gitops

# Install Git hooks
bash scripts/install-hooks.sh

# Deploy locally
docker compose up -d
```

## Pipeline Flow

1. Create feature branch
2. Make changes
3. Git hooks validate locally
4. Push triggers CI (ShellCheck + secret scan + Docker build)
5. Open Pull Request
6. CI must pass before merge
7. Merge to main triggers CD
8. Automatic deployment to server
9. Health check verification
10. Auto-rollback on failure

## Author

Ghaith — DevOps Engineering Portfolio
GitHub: https://github.com/ghaithsoltani
