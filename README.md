# TP Trivy Avancé - SBOM, IaC et Comparaison d'outils

 Ce repo contient des exemples de misconfigurations IaC intentionnelles pour tester Trivy.

## Contenu

- `terraform/` - Terraform avec misconfigurations AWS (S3 public, SG ouvert, RDS non chiffré)
- `k8s/` - Kubernetes avec pods privilégiés, hostNetwork, capabilities dangereuses

## Tests effectués (29/01/2026)

### IaC Terraform
```bash
trivy config terraform/
# 22 misconfigurations (1 CRITICAL, 12 HIGH, 4 MEDIUM, 5 LOW)
```

### IaC Kubernetes
```bash
trivy config k8s/
# 40 misconfigurations (8 HIGH, 10 MEDIUM, 22 LOW)
```

### Génération SBOM
```bash
trivy fs -f cyclonedx -o sbom.json .
trivy fs -f spdx-json -o sbom-spdx.json .
```

### Scan de SBOM existant
```bash
trivy sbom sbom.json
```

## Comparaison Trivy vs Grype

| Critère | Trivy | Grype |
|---------|-------|-------|
| Vulnérabilités | 19 | 18 |
| SBOM | Oui | Via Syft |
| IaC | Oui | Non |
| EPSS | Non | Oui |
| Secrets | Oui | Non |

## Lien avec le cours

Ce repo fait partie du Module 4 - Supply Chain Security (ENI Nantes).
