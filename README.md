# Interop Event Infrastructure 


## Scope

- Deploy Vidos resources using Terraform.
- Use the published provider from Terraform Registry.
- Store Terraform state in `tf-state` branch under `state/production/terraform.tfstate`.

## How it works

- Terraform code lives on `main`.
- Terraform state lives on `tf-state` branch.
- PR workflow runs `fmt`, `init`, `validate`, `plan` against production.
- Release workflow applies production on non-pre-release published releases.

## Secrets

Configure GitHub environment `production` with:
- `VIDOS_API_KEY` (required)
- `VIDOS_REGION` (optional, default `eu`)

## Workflows

- `.github/workflows/terraform-plan.yml`
- `.github/workflows/terraform-apply-release.yml`

See `docs/terraform-ci-state.md` for operational details.
