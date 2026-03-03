# Terraform CI with Git Branch State (Production Only)

## Branch model

- `main`: Terraform code
- `tf-state`: Terraform state file

State path:
- `state/production/terraform.tfstate`

## GitHub environment + secrets

Create GitHub environment:
- `production`

Add these secrets:
- `VIDOS_API_KEY`
- `VIDOS_REGION` (optional; defaults to `eu`)

Workflows export them as:
- `TF_VAR_vidos_api_key`
- `TF_VAR_vidos_region`

## Workflows

- `.github/workflows/terraform-plan.yml`
  - Trigger: Pull Requests
  - Runs `terraform fmt`, `init`, `validate`, and `plan`
  - Uses published provider with explicit Terraform CLI config (`direct {}` only)
  - Uses `state/production/terraform.tfstate`

- `.github/workflows/terraform-apply-release.yml`
  - Trigger: Release published
  - Applies production only (`prerelease` is ignored)
  - Uses published provider with explicit Terraform CLI config (`direct {}` only)
  - Commits updated state to `tf-state`

## Bootstrapping `tf-state`

1. Create `tf-state` branch from `main`.
2. Ensure `state/production/` exists on `tf-state`.
3. Push the branch.
