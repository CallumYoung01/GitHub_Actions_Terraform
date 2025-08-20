#!/bin/bash
set -euo pipefail

# --- Variables ---
RESOURCE_GROUP="tf-hub"
LOCATION="uksouth"
STORAGE_ACCOUNT_NAME="tfstate$RANDOM"
STORAGE_ACCOUNT_NAME=$(echo "$STORAGE_ACCOUNT_NAME" | tr '[:upper:]' '[:lower:]') # enforce lowercase
CONTAINER_NAME="tfstate"
APP_NAME="github-terraform-sp"
GITHUB_REPO="your-gh-org/your-repo"  # Format: org/repo

SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)

echo "▶ Using subscription: $SUBSCRIPTION_ID"
echo "▶ Using tenant: $TENANT_ID"
echo "▶ Resource group: $RESOURCE_GROUP"
echo "▶ Storage account: $STORAGE_ACCOUNT_NAME"
echo "▶ App registration: $APP_NAME"
echo "▶ GitHub repo: $GITHUB_REPO"

# --- Create resource group ---
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# --- Create storage account and blob container ---
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --encryption-services blob

STORAGE_KEY=$(az storage account keys list \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --query "[0].value" -o tsv)

az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_KEY"

# --- Create App Registration (Service Principal) ---
APP_ID=$(az ad app create --display-name "$APP_NAME" --query appId -o tsv)

# Assign RBAC role (Contributor on the subscription)
az role assignment create \
  --assignee "$APP_ID" \
  --role "Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION_ID"

# --- Add Federated Credential for GitHub OIDC ---
az ad app federated-credential create --id "$APP_ID" --parameters "{
  \"name\": \"GitHubActionsFederated\",
  \"issuer\": \"https://token.actions.githubusercontent.com\",
  \"subject\": \"repo:$GITHUB_REPO:ref:refs/heads/main\",
  \"audiences\": [\"api://AzureADTokenExchange\"]
}"

# --- Output Results ---
echo "✅ Setup Complete"
echo "App ID (Client ID): $APP_ID"
echo "Tenant ID: $TENANT_ID"
echo "Subscription ID: $SUBSCRIPTION_ID"
echo "Storage Account: $STORAGE_ACCOUNT_NAME"
echo "Container: $CONTAINER_NAME"

echo
echo "📌 Add this to your Terraform backend configuration:"
cat <<EOF

terraform {
  backend "azurerm" {
    resource_group_name   = "$RESOURCE_GROUP"
    storage_account_name  = "$STORAGE_ACCOUNT_NAME"
    container_name        = "$CONTAINER_NAME"
    key                   = "terraform.tfstate"
  }
}
EOF