terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.43"
    }
  }

  # Pre-existing setup
  backend "azurerm" {}
}

provider "azurerm" {
  features {
     resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  alias           = "sub" # Alias should be named as the service you're creating (DO NOT USE SPOKE)
  subscription_id = var.subscription_id
}