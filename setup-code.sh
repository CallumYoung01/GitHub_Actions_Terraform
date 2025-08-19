#!/bin/bash

# --- Variables ---
RESOURCE_GROUP="tf-hub"
LOCATION="uksouth"
STORAGE_ACCOUNT_NAME="tfstate$RANDOM"
CONTAINER_NAME="tfstate"
APP_NAME="github-terraform-sp"
GITHUB_REPO="your-gh-org/your-repo"  # Format: org/repo
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
TENANT_ID=$(az account show --query tenantId -o tsv)

# --- Create resource group ---
az group create --name $RESOURCE_GROUP --location $LOCATION

# --- Create storage account and blob container ---
az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

STORAGE_KEY=$(az storage account keys list \
  --account-name $STORAGE_ACCOUNT_NAME \
  --query "[0].value" -o tsv)

az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --account-key $STORAGE_KEY

# --- Create App Registration (Service Principal) ---
APP_ID=$(az ad app create --display-name $APP_NAME --query appId -o tsv)

# Assign RBAC role (Contributor on the whole subscription or a specific RG)
az role assignment create \
  --assignee $APP_ID \
  --role "Contributor" \
  --scope /subscriptions/$SUBSCRIPTION_ID

# --- Add Federated Credential for GitHub OIDC ---
az ad app federated-credential create --id $APP_ID --parameters '{
  "name": "GitHubActionsFederated",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:'"$GITHUB_REPO"':ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'

echo "✅ Setup Complete"
echo "App ID (Client ID): $APP_ID"
echo "Tenant ID: $TENANT_ID"
echo "Subscription ID: $SUBSCRIPTION_ID"
echo "Storage Account: $STORAGE_ACCOUNT_NAME"
