# How to use
todo 
- fix trivy 
- check read me 
- Check and fix on TF Provider - add this to documentation 
- Add variables and descriptions 
- naming module? 
- 


## Purpose
This repo is designed to help with setting up a multi-environment Terraform Deployment pipeline using GitHub Actions. 

## Prerequsits
- Manually created Storage Account to host tfstate. TODO - Create Powershell for this. How will it manage Private Endpoint. 
- Deployment account - Manually created app Reg using OIDC - ToDo - Create powershell script for this. 
- KeyVault
- Create GitHub Environments for DEV and QA - add App Reg Client ID, Client Secret, Tenant ID, Subscription ID

## Key Fetures 
- Terraform Infrastructure: The terraform directory contains Terraform code for Azure resources, including resource groups, app service plans, and an application gateway.
- Environment Separation: Environment-specific configuration is managed with separate backend and variable files for "dev" and "qa" (backend and terraform/config/).
- GitHub Actions Automation:
  - terraform-deployment.yml automates deployment (plan/apply) for each environment.
  - terraform-destroy.yml automates resource destruction.
  - Custom composite actions (.github/actions/terraform-deploy/, .github/actions/terraform-destroy/) encapsulate Terraform commands.
- Security Scanning: The deployment workflow includes a Trivy IaC security scan step.

